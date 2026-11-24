import '../../../../core/typedefs/typedefs.dart';
import '../entities/hit_record.dart';
import '../entities/table_def.dart';
import '../entities/table_shift.dart';

abstract interface class TablesRepository {
  Stream<List<TableDef>> watchTables();
  ResultFuture<TableDef> saveTable(TableDef table);
  Stream<List<TableShift>> watchShifts();
  ResultFuture<TableShift> addShift(TableShift shift);
  Stream<List<HitRecord>> watchHits();
  ResultFuture<HitRecord> addHit(HitRecord hit);
}
