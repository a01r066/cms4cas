import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/data/record_store.dart';

/// Overridden in bootstrap.
final prefsProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError('prefsProvider not overridden'));
final recordStoreProvider = Provider<RecordStore>((ref) => throw UnimplementedError('recordStoreProvider not overridden'));
