import 'package:dartz/dartz.dart';

import '../../../../core/error/failure_mapper.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/streams.dart';
import '../../../settings/domain/entities/app_settings.dart';
import '../../domain/repositories/demo_data_repository.dart';
import '../datasources/demo_data_datasource.dart';
import '../demo_data_generator.dart';

class DemoDataRepositoryImpl implements DemoDataRepository {
  DemoDataRepositoryImpl(this._ds, this._settings, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  final DemoDataDataSource _ds;
  final AppSettings Function() _settings;
  final DateTime Function() _clock;

  @override
  ResultFuture<int> load() async {
    try {
      return Right(await _ds.load(DemoData.build(now: _clock(), settings: _settings())));
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  @override
  ResultFuture<int> remove({String? keepUserId}) async {
    try {
      return Right(await _ds.remove(keepUserId: keepUserId));
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  @override
  Stream<bool> watchPresent() => _ds.watchPresent().mapErrorsToFailure();
}
