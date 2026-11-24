import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app_config.dart';
import '../../shared/providers.dart';
import '../data/repository.dart';
import 'roles.dart';

final usersRepoProvider = Provider((ref) => Repository<AppUser>(ref.watch(recordStoreProvider), 'users', AppUser.fromJson, (u) => u.toJson()));

final usersProvider = StreamProvider<List<AppUser>>((ref) => ref.watch(usersRepoProvider).watch());

/// Signed-in operator. Local mode: chosen from the user list (no password — device-trusted).
/// Cloud mode: Firebase Auth uid, profile in casinos/{id}/users/{uid}.
class SessionNotifier extends Notifier<String?> {
  static const _key = 'cms.currentUserId';
  @override
  String? build() => ref.watch(prefsProvider).getString(_key);

  Future<void> signInAs(String userId) async {
    await ref.read(prefsProvider).setString(_key, userId);
    state = userId;
  }

  Future<void> signOut() async {
    await ref.read(prefsProvider).remove(_key);
    state = null;
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, String?>(SessionNotifier.new);

final currentUserProvider = Provider<AppUser?>((ref) {
  final id = ref.watch(sessionProvider);
  final users = ref.watch(usersProvider).value ?? const [];
  if (id == null) return null;
  for (final u in users) {
    if (u.id == id) return u;
  }
  return null;
});

/// Local mode: writes the profile directly. Cloud mode: the `setUserRole` Cloud Function
/// assigns roles (Firestore rules forbid clients writing profiles). The account must
/// already exist in Firebase Auth; it is found by email, or by uid when editing.
Future<AppUser> createUser(WidgetRef ref, AppUser u) async {
  if (kUseFirebase) {
    final res = await FirebaseFunctions.instance.httpsCallable('setUserRole').call<Map<String, dynamic>>({
      'casinoId': kCasinoId,
      if (u.id.isNotEmpty) 'uid': u.id,
      'email': u.email,
      'name': u.name,
      'role': u.role.wire,
      'creditRole': u.creditRole?.wire,
    });
    final uid = (res.data['uid'] ?? u.id) as String;
    return AppUser(id: uid, name: u.name, role: u.role, creditRole: u.creditRole, email: u.email);
  }
  final repo = ref.read(usersRepoProvider);
  final id = u.id.isEmpty ? Repository.newId() : u.id;
  final user = AppUser(id: id, name: u.name, role: u.role, creditRole: u.creditRole, email: u.email);
  final r = await repo.save(id, user);
  return r.fold((f) => throw f, (x) => x);
}

/// Cloud mode: uid of the signed-in Firebase account (null in local mode).
String? get firebaseUid => kUseFirebase ? FirebaseAuth.instance.currentUser?.uid : null;
