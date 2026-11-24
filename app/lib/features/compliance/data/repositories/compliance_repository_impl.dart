import 'package:dartz/dartz.dart';

import '../../../../core/error/failure_mapper.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/streams.dart';
import '../../domain/entities/compliance_entities.dart';
import '../../domain/repositories/compliance_repository.dart';
import '../datasources/compliance_remote_datasource.dart';
import '../models/compliance_models.dart';

class ComplianceRepositoryImpl implements ComplianceRepository {
  ComplianceRepositoryImpl(this._ds);

  final ComplianceRemoteDataSource _ds;

  @override
  Stream<List<CashTxRecord>> watchCashTx() => _ds
      .watchCashTx()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => b.at.compareTo(a.at)))
      .mapErrorsToFailure();

  @override
  ResultFuture<CashTxRecord> addCashTx(CashTxRecord tx) => _guard(() => _ds.addCashTx(CashTxModel.fromEntity(tx)), tx);

  @override
  Stream<List<CtrReport>> watchCtrs() => _ds
      .watchCtrs()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => b.gamingDay.compareTo(a.gamingDay)))
      .mapErrorsToFailure();

  @override
  ResultFuture<CtrReport> createCtr(CtrReport report) => _guard(() => _ds.createCtr(CtrReportModel.fromEntity(report)), report);

  @override
  ResultVoid setCtrFields(String ctrId, Map<String, bool> fields) => _guard(() => _ds.setCtrFields(ctrId, fields), unit);

  @override
  ResultVoid advanceCtr(String ctrId, CtrStatus to) => _guard(() => _ds.advanceCtr(ctrId, to.wire), unit);

  @override
  Stream<List<BarredPatron>> watchBarred() =>
      _ds.watchBarred().map((l) => l.map((m) => m.toEntity()).toList()).mapErrorsToFailure();

  @override
  ResultFuture<BarredPatron> saveBarred(BarredPatron b) => _guard(() => _ds.saveBarred(BarredPatronModel.fromEntity(b)), b);

  @override
  Stream<List<SarCase>> watchSars() => _ds
      .watchSars()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => b.detectedAt.compareTo(a.detectedAt)))
      .mapErrorsToFailure();

  @override
  ResultFuture<SarCase> saveSar(SarCase s) => _guard(() => _ds.saveSar(SarCaseModel.fromEntity(s)), s);

  ResultFuture<T> _guard<T>(Future<void> Function() f, T value) async {
    try {
      await f();
      return Right(value);
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }
}
