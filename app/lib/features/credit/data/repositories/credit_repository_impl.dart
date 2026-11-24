import 'package:dartz/dartz.dart';

import '../../../../core/error/failure_mapper.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/streams.dart';
import '../../domain/entities/credit_application.dart';
import '../../domain/entities/marker.dart';
import '../../domain/repositories/credit_repository.dart';
import '../datasources/credit_remote_datasource.dart';
import '../models/credit_models.dart';

class CreditRepositoryImpl implements CreditRepository {
  CreditRepositoryImpl(this._ds);

  final CreditRemoteDataSource _ds;

  @override
  Stream<List<CreditApplication>> watchApplications() => _ds
      .watchApplications()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt)))
      .mapErrorsToFailure();

  @override
  Stream<List<Marker>> watchMarkers() => _ds
      .watchMarkers()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => b.issuedAt.compareTo(a.issuedAt)))
      .mapErrorsToFailure();

  @override
  ResultFuture<CreditApplication> createApplication(CreditApplication app) =>
      _value(() => _ds.createApplication(CreditApplicationModel.fromEntity(app)).then((_) => app));

  @override
  ResultVoid saveAssessment(CreditApplication app) =>
      _void(() => _ds.saveAssessment(app.id, app.answers, app.outcome?.wire ?? '', app.referrals));

  @override
  ResultVoid submitForSignatures(String appId) => _void(() => _ds.submitForSignatures(appId));

  @override
  ResultVoid sign(String appId) => _void(() => _ds.sign(appId));

  @override
  ResultVoid approve(String appId) => _void(() => _ds.decide(appId, approve: true));

  @override
  ResultVoid decline(String appId, String reason) => _void(() => _ds.decide(appId, approve: false, reason: reason));

  @override
  ResultFuture<String> issueMarker({required String playerId, required String number, required String table, required double amount}) =>
      _value(() => _ds.issueMarker(playerId: playerId, number: number, table: table, amount: amount));

  @override
  ResultVoid recordPayment(String markerId, double amount, String method) => _void(() => _ds.recordPayment(markerId, amount, method));

  @override
  ResultVoid signWriteOff(String markerId, String reason) => _void(() => _ds.signWriteOff(markerId, reason));

  @override
  ResultVoid writeOff(String markerId, String reason) => _void(() => _ds.writeOff(markerId, reason));

  @override
  ResultVoid saveCollectionNote(String markerId, String note) => _void(() => _ds.saveCollectionNote(markerId, note));

  ResultFuture<T> _value<T>(Future<T> Function() f) async {
    try {
      return Right(await f());
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  ResultVoid _void(Future<void> Function() f) => _value(() async {
        await f();
        return unit;
      });
}
