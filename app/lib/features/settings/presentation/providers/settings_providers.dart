import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/backend_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/settings_remote_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

final settingsDataSourceProvider = Provider((ref) => SettingsRemoteDataSource(ref.watch(recordStoreProvider)));

final settingsRepositoryProvider =
    Provider<SettingsRepository>((ref) => SettingsRepositoryImpl(ref.watch(settingsDataSourceProvider)));

/// Book defaults while signed out or loading.
final settingsStreamProvider = StreamProvider<AppSettings>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const AppSettings());
  return ref.watch(settingsRepositoryProvider).watch();
});

final settingsProvider = Provider<AppSettings>((ref) => ref.watch(settingsStreamProvider).value ?? const AppSettings());
