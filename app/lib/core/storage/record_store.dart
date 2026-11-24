import '../typedefs/typedefs.dart';

/// Persistence port used by feature datasources. Every collection holds JSON
/// documents keyed by id. Implementations throw; repositories map to Failure.
/// [LocalRecordStore] (device) and [FirestoreRecordStore] (casinos/{casinoId}/…).
abstract class RecordStore {
  String get modeLabel;
  Stream<List<Json>> watch(String collection);
  Stream<Json?> watchOne(String collection, String id);
  Future<List<Json>> list(String collection);
  Future<Json?> get(String collection, String id);
  /// Create or replace a whole document.
  Future<void> put(String collection, String id, Json data);

  /// Change only [fields] of an existing document (Firestore `update`).
  Future<void> patch(String collection, String id, Json fields);
  Future<void> delete(String collection, String id);
}
