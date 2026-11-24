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

  @override
  Future<void> patch(String collection, String id, Json fields) => _col(collection).doc(id).update(fields);

  @override
  Future<void> delete(String collection, String id) => _col(collection).doc(id).delete();
}
