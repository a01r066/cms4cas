import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/storage/prefs_service.dart';

/// Overridden in bootstrap (and in tests).
final prefsProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError('prefsProvider not overridden'));

final prefsServiceProvider = Provider<PrefsService>((ref) => PrefsService(ref.watch(prefsProvider)));
