import 'package:shared_preferences/shared_preferences.dart';

/// Typed access to the few device preferences the app keeps.
class PrefsService {
  PrefsService(this._prefs);

  final SharedPreferences _prefs;

  static const _sessionKey = 'cms.currentUserId';

  /// Local backend only: the operator picked on this device.
  String? get sessionUserId => _prefs.getString(_sessionKey);

  Future<void> setSessionUserId(String? id) =>
      id == null ? _prefs.remove(_sessionKey) : _prefs.setString(_sessionKey, id);

  SharedPreferences get raw => _prefs;
}
