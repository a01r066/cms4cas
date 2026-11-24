import '../../../../core/storage/record_store.dart';
import '../models/settings_model.dart';

class SettingsRemoteDataSource {
  SettingsRemoteDataSource(this._store);

  final RecordStore _store;

  static const collection = 'settings';
  static const docId = 'main';

  /// Missing document → book defaults.
  Stream<SettingsModel> watch() =>
      _store.watchOne(collection, docId).map((j) => j == null ? const SettingsModel() : SettingsModel.fromJson(j));

  Future<void> save(SettingsModel m) => _store.put(collection, docId, m.toJson());
}
