/// Thrown by a privileged action (Cloud Function or its local equivalent).
/// [message] is written for the user, like an `HttpsError` message.
class ServerException implements Exception {
  const ServerException(this.code, this.message);

  final String code; // permission-denied, failed-precondition, invalid-argument, not-found, unauthenticated
  final String message;

  @override
  String toString() => 'ServerException($code): $message';
}

/// Stored data could not be decoded.
class StorageFormatException implements Exception {
  const StorageFormatException(this.message);

  final String message;

  @override
  String toString() => 'StorageFormatException: $message';
}
