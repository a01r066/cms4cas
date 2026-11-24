import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/backend/functions_gateway.dart';
import '../../../../core/storage/prefs_service.dart';
import '../../../../core/storage/record_store.dart';
import '../models/app_user_model.dart';

/// Sign-in and operator profiles. Two implementations because authentication
/// genuinely differs: Firebase Auth (passwords) vs. picking an operator on a
/// trusted demo/training device. Both read profiles from `users` and assign
/// roles only through the `setUserRole` action.
abstract class AuthRemoteDataSource {
  /// Signed-in uid, or null.
  Stream<String?> watchUid();
  String? get currentUid;

  Future<void> signInWithEmail(String email, String password);
  Future<void> signInAs(String userId);
  Future<void> signOut();

  Stream<AppUserModel?> watchProfile(String uid);
  Stream<List<AppUserModel>> watchUsers();

  /// Creates/updates a profile through the privileged action; returns the uid.
  Future<String> setUserRole({String? uid, String? email, required String name, required String role, String? creditRole});
}

const _users = 'users';

abstract class _ProfilesFromStore implements AuthRemoteDataSource {
  RecordStore get store;
  FunctionsGateway get functions;

  @override
  Stream<AppUserModel?> watchProfile(String uid) =>
      store.watchOne(_users, uid).map((j) => j == null ? null : AppUserModel.fromJson(j));

  @override
  Stream<List<AppUserModel>> watchUsers() => store.watch(_users).map((l) => l.map(AppUserModel.fromJson).toList());

  @override
  Future<String> setUserRole({String? uid, String? email, required String name, required String role, String? creditRole}) async {
    final res = await functions.call('setUserRole', {
      if (uid != null && uid.isNotEmpty) 'uid': uid,
      if (email != null && email.isNotEmpty) 'email': email,
      'name': name,
      'role': role,
      'creditRole': creditRole,
    });
    return (res['uid'] ?? uid ?? '') as String;
  }
}

class FirebaseAuthRemoteDataSource extends _ProfilesFromStore {
  FirebaseAuthRemoteDataSource(this._auth, this.store, this.functions);

  final FirebaseAuth _auth;
  @override
  final RecordStore store;
  @override
  final FunctionsGateway functions;

  @override
  Stream<String?> watchUid() => _auth.authStateChanges().map((u) => u?.uid);

  @override
  String? get currentUid => _auth.currentUser?.uid;

  @override
  Future<void> signInWithEmail(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

  @override
  Future<void> signInAs(String userId) =>
      throw UnsupportedError('Picking an operator is only available on the local backend.');

  @override
  Future<void> signOut() => _auth.signOut();
}

class LocalAuthRemoteDataSource extends _ProfilesFromStore {
  LocalAuthRemoteDataSource(this._prefs, this.store, this.functions);

  final PrefsService _prefs;
  @override
  final RecordStore store;
  @override
  final FunctionsGateway functions;
  final _changes = StreamController<String?>.broadcast();

  @override
  Stream<String?> watchUid() => Stream<String?>.multi((sink) {
        sink.add(_prefs.sessionUserId);
        final sub = _changes.stream.listen(sink.add);
        sink.onCancel = sub.cancel;
      });

  @override
  String? get currentUid => _prefs.sessionUserId;

  @override
  Future<void> signInWithEmail(String email, String password) =>
      throw UnsupportedError('Email sign-in needs the Firebase backend.');

  @override
  Future<void> signInAs(String userId) async {
    await _prefs.setSessionUserId(userId);
    _changes.add(userId);
  }

  @override
  Future<void> signOut() async {
    await _prefs.setSessionUserId(null);
    _changes.add(null);
  }
}
