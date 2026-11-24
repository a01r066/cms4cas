import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/providers/auth_providers.dart';
import '../shared/providers/backend_providers.dart';

/// Reacts to signed-in → signed-out: nothing of the previous operator stays in
/// memory. Patron data is never cached on disk (Firestore persistence is off in
/// bootstrap), so dropping the live listeners is enough. Fires only on that
/// transition. Read eagerly in bootstrap.
final sessionCleanupProvider = Provider<void>((ref) {
  ref.listen<AsyncValue<String?>>(authUidProvider, (prev, next) {
    final was = prev?.value;
    final now = next.value;
    if (was != null && now == null) {
      // Data providers re-key on currentUserProvider and return empty lists; this
      // also drops any cached profile.
      ref.invalidate(currentUserProvider);
      if (ref.read(backendProvider) == Backend.firebase && !kIsWeb) {
        FirebaseCrashlytics.instance.setUserIdentifier('');
      }
    } else if (now != null && now != was && ref.read(backendProvider) == Backend.firebase && !kIsWeb) {
      FirebaseCrashlytics.instance.setUserIdentifier(now);
    }
  });
});
