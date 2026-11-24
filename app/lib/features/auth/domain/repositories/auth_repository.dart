import '../../../../core/typedefs/typedefs.dart';
import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<String?> watchUid();
  String? get currentUid;
  Stream<AppUser?> watchProfile(String uid);
  Stream<List<AppUser>> watchUsers();

  ResultVoid signInWithEmail(String email, String password);
  ResultVoid signInAs(String userId);
  ResultVoid signOut();

  /// [user.id] empty → new profile (found by [AppUser.email] on Firebase). Returns the saved user.
  ResultFuture<AppUser> saveUser(AppUser user);
}
