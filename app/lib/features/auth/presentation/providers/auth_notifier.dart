import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/session/before_sign_out_hooks.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repo, this._hooks) : super(const AuthState());

  final AuthRepository _repo;
  final BeforeSignOutHooks _hooks;

  ResultVoid signInWithEmail(String email, String password) => _run(() => _repo.signInWithEmail(email, password));

  ResultVoid signInAs(String userId) => _run(() => _repo.signInAs(userId));

  /// Runs before-sign-out hooks while still signed in, then signs out.
  /// Session cleanup (app/session_cleanup.dart) reacts to the transition.
  ResultVoid signOut() => _run(() async {
        await _hooks.runAll();
        return _repo.signOut();
      });

  /// Create or update an operator. With [firstAdmin] the caller sets itself up as
  /// the casino's first administrator (allowed only while the casino has no users)
  /// and, on the local backend, is signed in as that user.
  ResultFuture<AppUser> saveUser(AppUser user, {bool firstAdmin = false}) => _run(() async {
        final draft = firstAdmin && user.id.isEmpty ? user.copyWith(id: _repo.currentUid ?? '') : user;
        final r = await _repo.saveUser(draft);
        if (firstAdmin) {
          final saved = r.toOption().toNullable();
          if (saved != null && _repo.currentUid != saved.id) {
            final s = await _repo.signInAs(saved.id);
            if (s.isLeft()) return Left<Failure, AppUser>(s.swap().getOrElse(() => const Failure('Sign-in failed.')));
          }
        }
        return r;
      });

  Future<Either<Failure, T>> _run<T>(Future<Either<Failure, T>> Function() f) async {
    state = state.copyWith(busy: true, failure: null);
    final r = await f();
    if (!mounted) return r;
    state = r.fold((f) => state.copyWith(busy: false, failure: f), (_) => state.copyWith(busy: false));
    return r;
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider), ref.watch(beforeSignOutHooksProvider)),
);
