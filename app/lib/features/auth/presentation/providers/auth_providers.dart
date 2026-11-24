import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/backend_providers.dart';
import '../../../../shared/providers/firebase_providers.dart';
import '../../../../shared/providers/prefs_provider.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

final authDataSourceProvider = Provider<AuthRemoteDataSource>((ref) => switch (ref.watch(backendProvider)) {
      Backend.firebase => FirebaseAuthRemoteDataSource(
          ref.watch(firebaseAuthProvider), ref.watch(recordStoreProvider), ref.watch(functionsGatewayProvider)),
      Backend.local => LocalAuthRemoteDataSource(
          ref.watch(prefsServiceProvider), ref.watch(recordStoreProvider), ref.watch(functionsGatewayProvider)),
    });

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepositoryImpl(ref.watch(authDataSourceProvider)));

/// Signed-in uid (Firebase Auth uid, or the operator picked on a local device).
final authUidProvider = StreamProvider<String?>((ref) => ref.watch(authRepositoryProvider).watchUid());

/// The signed-in operator's CMS profile; null when signed out or when the account has no role yet.
final currentUserProvider = StreamProvider<AppUser?>((ref) {
  final uid = ref.watch(authUidProvider).value;
  if (uid == null) return Stream.value(null);
  return ref.watch(authRepositoryProvider).watchProfile(uid);
});

/// Convenience for widgets: the operator or null while loading / signed out.
final currentUserValueProvider = Provider<AppUser?>((ref) => ref.watch(currentUserProvider).value);

/// All operators — only for signed-in members (empty when signed out, so rules never reject).
final usersProvider = StreamProvider<List<AppUser>>((ref) {
  if (ref.watch(currentUserValueProvider) == null) return Stream.value(const []);
  return ref.watch(authRepositoryProvider).watchUsers();
});

/// Local backend only: operators that can be picked on this device's sign-in screen.
final localSignInUsersProvider = StreamProvider<List<AppUser>>((ref) {
  if (ref.watch(backendProvider) != Backend.local) return Stream.value(const []);
  return ref.watch(authRepositoryProvider).watchUsers();
});
