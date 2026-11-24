import '../../../../core/storage/record_store.dart';
import '../models/table_models.dart';

class TablesRemoteDataSource {
  TablesRemoteDataSource(this._store);

  final RecordStore _store;

  static const tables = 'tables';
  static const shifts = 'table_shifts';
  static const hits = 'hits';

  Stream<List<TableDefModel>> watchTables() => _store.watch(tables).map((l) => l.map(TableDefModel.fromJson).toList());
  Future<void> saveTable(TableDefModel m) => _store.put(tables, m.id, m.toJson());

  Stream<List<TableShiftModel>> watchShifts() => _store.watch(shifts).map((l) => l.map(TableShiftModel.fromJson).toList());

  /// Shifts are append-only for non-admins (rules).
  Future<void> addShift(TableShiftModel m) => _store.put(shifts, m.id, m.toJson());

  Stream<List<HitRecordModel>> watchHits() => _store.watch(hits).map((l) => l.map(HitRecordModel.fromJson).toList());
  Future<void> addHit(HitRecordModel m) => _store.put(hits, m.id, m.toJson());
}
