import 'package:dartz/dartz.dart';

import '../../../../core/error/failure_mapper.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/streams.dart';
import '../../domain/entities/access_request.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._ds);

  final AuthRemoteDataSource _ds;

  @override
  Stream<String?> watchUid() => _ds.watchUid().mapErrorsToFailure();

  @override
  String? get currentUid => _ds.currentUid;

  @override
  Stream<AppUser?> watchProfile(String uid) => _ds.watchProfile(uid).map((m) => m?.toEntity()).mapErrorsToFailure();

  @override
  Stream<List<AppUser>> watchUsers() => _ds
      .watchUsers()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())))
      .mapErrorsToFailure();

  @override
  ResultVoid signInWithEmail(String email, String password) => _guard(() => _ds.signInWithEmail(email, password));

  @override
  ResultVoid signInAs(String userId) => _guard(() => _ds.signInAs(userId));

  @override
  ResultVoid signOut() => _guard(_ds.signOut);

  @override
  ResultFuture<String> register({required String name, required String email, required String password}) async {
    try {
      return Right(await _ds.register(name: name, email: email, password: password));
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  @override
  ResultVoid sendPasswordReset(String email) => _guard(() => _ds.sendPasswordReset(email));

  @override
  bool get emailVerified => _ds.emailVerified;

  @override
  ResultVoid resendVerificationEmail() => _guard(_ds.resendVerificationEmail);

  @override
  Stream<List<AccessRequest>> watchAccessRequests() => _ds
      .watchAccessRequests()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => a.requestedAt.compareTo(b.requestedAt)))
      .mapErrorsToFailure();

  @override
  ResultVoid dismissAccessRequest(String uid) => _guard(() => _ds.dismissAccessRequest(uid));

  @override
  ResultFuture<AppUser> saveUser(AppUser user) async {
    try {
      final uid = await _ds.setUserRole(
        uid: user.id,
        email: user.email,
        name: user.name,
        role: user.role.wire,
        creditRole: user.creditRole?.wire,
      );
      return Right(user.copyWith(id: uid));
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  ResultVoid _guard(Future<void> Function() f) async {
    try {
      await f();
      return const Right(unit);
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }
}
