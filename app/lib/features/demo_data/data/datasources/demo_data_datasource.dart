import '../../../../core/storage/record_store.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../demo_data_generator.dart';

/// Writes and removes demo records through the app's [RecordStore].
/// Throws; the repository maps errors to Failure.
class DemoDataDataSource {
  DemoDataDataSource(this._store);

  final RecordStore _store;

  /// Writes every collection; existing demo records with the same id are replaced.
  Future<int> load(Map<String, Map<String, Json>> data) async {
    var n = 0;
    for (final c in DemoData.collections) {
      final docs = data[c] ?? const {};
      if (docs.isEmpty) continue;
      await _store.putAll(c, docs);
      n += docs.length;
    }
    return n;
  }

  /// Deletes every record whose id starts with [DemoData.prefix], except [keepUserId].
  Future<int> remove({String? keepUserId}) async {
    var n = 0;
    for (final c in DemoData.collections.reversed) {
      final ids = (await _store.list(c))
          .map((j) => (j['id'] ?? j['uid'] ?? '') as String)
          .where((id) => id.startsWith(DemoData.prefix) && !(c == 'users' && id == keepUserId))
          .toList();
      if (ids.isEmpty) continue;
      await _store.deleteAll(c, ids);
      n += ids.length;
    }
    return n;
  }

  /// Whether demo players are present (cheap signal for the UI).
  Stream<bool> watchPresent() =>
      _store.watch('players').map((l) => l.any((j) => (j['id'] as String? ?? '').startsWith(DemoData.prefix)));
}
