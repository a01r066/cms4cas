import 'package:dartz/dartz.dart';

import '../../../../core/error/failure_mapper.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/streams.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_datasource.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._ds);

  final SettingsRemoteDataSource _ds;

  @override
  Stream<AppSettings> watch() => _ds.watch().map((m) => m.toEntity()).mapErrorsToFailure();

  @override
  ResultFuture<AppSettings> save(AppSettings settings) async {
    try {
      await _ds.save(SettingsModel.fromEntity(settings));
      return Right(settings);
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }
}
