import '../../../../core/typedefs/typedefs.dart';
import '../entities/access_request.dart';
import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<String?> watchUid();
  String? get currentUid;
  Stream<AppUser?> watchProfile(String uid);
  Stream<List<AppUser>> watchUsers();

  ResultVoid signInWithEmail(String email, String password);
  ResultVoid signInAs(String userId);
  ResultVoid signOut();

  /// Creates a Firebase account and files an access request. Returns the uid.
  ResultFuture<String> register({required String name, required String email, required String password});
  ResultVoid sendPasswordReset(String email);
  bool get emailVerified;
  ResultVoid resendVerificationEmail();

  Stream<List<AccessRequest>> watchAccessRequests();
  ResultVoid dismissAccessRequest(String uid);

  /// [user.id] empty → new profile (found by [AppUser.email] on Firebase). Returns the saved user.
  ResultFuture<AppUser> saveUser(AppUser user);
}
