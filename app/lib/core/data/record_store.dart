import '../typedefs/typedefs.dart';

/// Persistence port. Every collection holds JSON documents keyed by id.
/// Implementations: [LocalRecordStore] (device storage) and [FirestoreRecordStore].
abstract class RecordStore {
  String get modeLabel;
  Stream<List<Json>> watch(String collection);
  Future<List<Json>> list(String collection);
  Future<Json?> get(String collection, String id);
  Future<void> put(String collection, String id, Json data);
  Future<void> delete(String collection, String id);
}
