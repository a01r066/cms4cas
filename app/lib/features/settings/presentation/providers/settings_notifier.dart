import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/typedefs/typedefs.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_providers.dart';
import 'settings_state.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier(this._repo) : super(const SettingsState());

  final SettingsRepository _repo;

  ResultFuture<AppSettings> save(AppSettings s) async {
    state = state.copyWith(saving: true, failure: null);
    final r = await _repo.save(s);
    if (mounted) state = r.fold((f) => state.copyWith(saving: false, failure: f), (_) => state.copyWith(saving: false));
    return r;
  }

  /// Book (Nevada 2003) values; keeps the casino's name.
  ResultFuture<AppSettings> resetToBookDefaults(AppSettings current) => save(AppSettings(casinoName: current.casinoName));
}

final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) => SettingsNotifier(ref.watch(settingsRepositoryProvider)));
