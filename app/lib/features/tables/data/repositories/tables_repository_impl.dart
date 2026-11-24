import 'package:dartz/dartz.dart';

import '../../../../core/error/failure_mapper.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/streams.dart';
import '../../domain/entities/hit_record.dart';
import '../../domain/entities/table_def.dart';
import '../../domain/entities/table_shift.dart';
import '../../domain/repositories/tables_repository.dart';
import '../datasources/tables_remote_datasource.dart';
import '../models/table_models.dart';

class TablesRepositoryImpl implements TablesRepository {
  TablesRepositoryImpl(this._ds);

  final TablesRemoteDataSource _ds;

  @override
  Stream<List<TableDef>> watchTables() => _ds
      .watchTables()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => a.name.compareTo(b.name)))
      .mapErrorsToFailure();

  @override
  ResultFuture<TableDef> saveTable(TableDef table) => _guard(() => _ds.saveTable(TableDefModel.fromEntity(table)), table);

  @override
  Stream<List<TableShift>> watchShifts() => _ds
      .watchShifts()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => b.gamingDay.compareTo(a.gamingDay)))
      .mapErrorsToFailure();

  @override
  ResultFuture<TableShift> addShift(TableShift shift) => _guard(() => _ds.addShift(TableShiftModel.fromEntity(shift)), shift);

  @override
  Stream<List<HitRecord>> watchHits() => _ds.watchHits().map((l) => l.map((m) => m.toEntity()).toList()).mapErrorsToFailure();

  @override
  ResultFuture<HitRecord> addHit(HitRecord hit) => _guard(() => _ds.addHit(HitRecordModel.fromEntity(hit)), hit);

  ResultFuture<T> _guard<T>(Future<void> Function() f, T value) async {
    try {
      await f();
      return Right(value);
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }
}
