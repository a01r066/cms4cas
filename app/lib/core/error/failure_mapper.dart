import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'exceptions.dart';
import 'failure.dart';

/// Single place that turns exceptions into user-facing messages.
Failure mapToFailure(Object e, [StackTrace? st]) {
  if (e is Failure) return e;
  if (e is ServerException) return Failure(e.message, code: e.code, cause: e);
  if (e is StorageFormatException) {
    return Failure('The saved data could not be read (${e.message}).', code: 'data-format', cause: e);
  }
  if (e is FormatException) {
    return Failure('The saved data could not be read (${e.message}).', code: 'data-format', cause: e);
  }
  if (e is FirebaseFunctionsException) {
    // Our functions throw HttpsError with messages written for users.
    const userFacing = {'permission-denied', 'failed-precondition', 'invalid-argument', 'not-found', 'already-exists', 'unauthenticated'};
    if (userFacing.contains(e.code) && (e.message ?? '').isNotEmpty) return Failure(e.message!, code: e.code, cause: e);
    return _byCode(e.code, e);
  }
  if (e is UnsupportedError) return Failure(e.message ?? 'Not available here.', code: 'unsupported', cause: e);
  if (e is FirebaseAuthException) {
    return switch (e.code) {
      'invalid-credential' || 'wrong-password' || 'user-not-found' =>
        Failure('Email or password is incorrect.', code: e.code, cause: e),
      'invalid-email' => Failure('Enter a valid email address.', code: e.code, cause: e),
      'email-already-in-use' =>
        Failure('An account already exists for this email. Sign in, or reset the password.', code: e.code, cause: e),
      'weak-password' => Failure('Choose a stronger password (at least 8 characters).', code: e.code, cause: e),
      'operation-not-allowed' =>
        Failure('Email/password sign-in is not enabled for this Firebase project.', code: e.code, cause: e),
      'user-disabled' => Failure('This account has been disabled. Contact an administrator.', code: e.code, cause: e),
      'too-many-requests' => Failure('Too many attempts. Wait a few minutes and try again.', code: e.code, cause: e),
      'network-request-failed' => Failure('No connection. Check the network and try again.', code: e.code, cause: e),
      _ => Failure('Sign-in failed. Please try again.', code: e.code, cause: e),
    };
  }
  if (e is FirebaseException) return _byCode(e.code, e);
  return Failure('Something went wrong. Please try again.', cause: e);
}

Failure _byCode(String code, Object e) => switch (code) {
      'permission-denied' => Failure('You do not have permission for this action.', code: code, cause: e),
      'unauthenticated' => Failure('Your session has ended. Sign in again.', code: code, cause: e),
      'unavailable' || 'deadline-exceeded' =>
        Failure('The server is unreachable. Check the connection and try again.', code: code, cause: e),
      'not-found' => Failure('The record no longer exists.', code: code, cause: e),
      _ => Failure('Something went wrong. Please try again.', code: code, cause: e),
    };
