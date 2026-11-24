import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../error/exceptions.dart';
import '../typedefs/typedefs.dart';
import 'record_store.dart';

/// Device-local storage (browser localStorage on web). Dev flavor without Firebase:
/// demos, training and offline evaluation. Not for live patron data.
class LocalRecordStore implements RecordStore {
  final SharedPreferences prefs;
  final _controllers = <String, StreamController<List<Json>>>{};
  LocalRecordStore(this.prefs);

  @override
  String get modeLabel => 'Local mode (this device only)';

  String _key(String c) => 'cms.$c';

  Map<String, Json> _read(String c) {
    final Object? stored = prefs.get(_key(c));
    if (stored == null) return {};
    final decoded = stored is String ? jsonDecode(stored) : stored;
    if (decoded is! Map) throw StorageFormatException('expected a map of records, found ${decoded.runtimeType}');
    final m = Map<String, dynamic>.from(decoded);
    return m.map((k, v) => MapEntry(k, Map<String, dynamic>.from(v as Map)));
  }

  Future<void> _write(String c, Map<String, Json> m) async {
    await prefs.setString(_key(c), jsonEncode(m));
    _controllers[c]?.add(m.values.toList());
  }

  @override
  Stream<List<Json>> watch(String collection) {
    final ctrl = _controllers.putIfAbsent(collection, () => StreamController<List<Json>>.broadcast());
    return Stream<List<Json>>.multi((sink) {
      try {
        sink.add(_read(collection).values.toList());
      } catch (e, st) {
        sink.addError(StorageFormatException('stored "$collection" data could not be read: $e'), st);
      }
      final sub = ctrl.stream.listen(sink.add, onError: sink.addError);
      sink.onCancel = sub.cancel;
    });
  }

  @override
  Stream<Json?> watchOne(String collection, String id) =>
      watch(collection).map((l) => l.where((j) => j['id'] == id).firstOrNull);

  @override
  Future<List<Json>> list(String collection) async => _read(collection).values.toList();

  @override
  Future<Json?> get(String collection, String id) async => _read(collection)[id];

  @override
  Future<void> put(String collection, String id, Json data) async {
    final m = _read(collection);
    m[id] = {...data, 'id': id};
    await _write(collection, m);
  }

  @override
  Future<void> patch(String collection, String id, Json fields) async {
    final m = _read(collection);
    final cur = m[id];
    if (cur == null) throw StorageFormatException('no "$collection" record $id to update');
    m[id] = {...cur, ...fields, 'id': id};
    await _write(collection, m);
  }

  @override
  Future<void> delete(String collection, String id) async {
    final m = _read(collection)..remove(id);
    await _write(collection, m);
  }
}
