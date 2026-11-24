import 'package:cloud_firestore/cloud_firestore.dart';
import '../typedefs/typedefs.dart';
import 'record_store.dart';

/// Firestore layout: casinos/{casinoId}/{collection}/{id}. See docs/04_data_model.md.
class FirestoreRecordStore implements RecordStore {
  final FirebaseFirestore db;
  final String casinoId;
  FirestoreRecordStore(this.db, this.casinoId);

  @override
  String get modeLabel => 'Cloud mode (Firebase · $casinoId)';

  CollectionReference<Json> _col(String c) => db.collection('casinos').doc(casinoId).collection(c);

  @override
  Stream<List<Json>> watch(String collection) =>
      _col(collection).snapshots().map((s) => s.docs.map((d) => {...d.data(), 'id': d.id}).toList());

  @override
  Stream<Json?> watchOne(String collection, String id) =>
      _col(collection).doc(id).snapshots().map((d) => d.exists ? {...d.data()!, 'id': d.id} : null);

  @override
  Future<List<Json>> list(String collection) async =>
      (await _col(collection).get()).docs.map((d) => {...d.data(), 'id': d.id}).toList();

  @override
  Future<Json?> get(String collection, String id) async {
    final d = await _col(collection).doc(id).get();
    return d.exists ? {...d.data()!, 'id': d.id} : null;
  }

  @override
  Future<void> put(String collection, String id, Json data) => _col(collection).doc(id).set({...data, 'id': id});

  /// Firestore allows 500 writes per batch.
  static const _batchSize = 450;

  @override
  Future<void> putAll(String collection, Map<String, Json> docs) async {
    final entries = docs.entries.toList();
    for (var i = 0; i < entries.length; i += _batchSize) {
      final batch = db.batch();
      for (final e in entries.skip(i).take(_batchSize)) {
        batch.set(_col(collection).doc(e.key), {...e.value, 'id': e.key});
      }
      await batch.commit();
    }
  }

  @override
  Future<void> deleteAll(String collection, Iterable<String> ids) async {
    final list = ids.toList();
    for (var i = 0; i < list.length; i += _batchSize) {
      final batch = db.batch();
      for (final id in list.skip(i).take(_batchSize)) {
        batch.delete(_col(collection).doc(id));
      }
      await batch.commit();
    }
  }

  @override
  Future<void> patch(String collection, String id, Json fields) => _col(collection).doc(id).update(fields);

  @override
  Future<void> delete(String collection, String id) => _col(collection).doc(id).delete();
}
