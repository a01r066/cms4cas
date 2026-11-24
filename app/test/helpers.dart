import 'package:cms_kiss/app/local_backend.dart';
import 'package:cms_kiss/core/storage/record_store.dart';
import 'package:cms_kiss/features/auth/presentation/providers/auth_notifier.dart';
import 'package:cms_kiss/features/auth/presentation/providers/auth_providers.dart';
import 'package:cms_kiss/shared/providers/backend_providers.dart';
import 'package:cms_kiss/shared/providers/prefs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local backend with the real action handlers — the same wiring as bootstrap.
Future<List<Override>> localOverrides([Map<String, Object> prefs = const {}, Backend backend = Backend.local]) async {
  SharedPreferences.setMockInitialValues(prefs);
  final p = await SharedPreferences.getInstance();
  return [
    prefsProvider.overrideWithValue(p),
    backendProvider.overrideWithValue(backend),
    localFunctionHandlersProvider.overrideWithValue(localFunctionHandlers()),
  ];
}

Future<ProviderContainer> localContainer([Map<String, Object> prefs = const {}]) async {
  final c = ProviderContainer(overrides: await localOverrides(prefs));
  // Keep the session providers alive like the widget tree would.
  c.listen(currentUserProvider, (_, _) {});
  return c;
}

RecordStore store(ProviderContainer c) => c.read(recordStoreProvider);

/// Lets streams deliver.
Future<void> settle() async {
  for (var i = 0; i < 5; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

/// Seeds a profile and signs in as it.
Future<void> signInAs(ProviderContainer c, String id, Map<String, dynamic> profile) async {
  await store(c).put('users', id, {'id': id, ...profile});
  await c.read(authNotifierProvider.notifier).signInAs(id);
  await settle();
  if (c.read(currentUserValueProvider)?.id != id) throw StateError('sign-in as $id did not take');
}

/// Data streams key on the current user; keep them listened to in tests.
void keepAlive(ProviderContainer c, List<ProviderListenable<Object?>> providers) {
  for (final p in providers) {
    c.listen(p, (_, _) {});
  }
}
