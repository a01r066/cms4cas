/// A user-presentable failure. Datasources throw; repositories map to Failure.
class Failure {
  final String displayMessage;
  final Object? cause;
  const Failure(this.displayMessage, [this.cause]);
  @override
  String toString() => displayMessage;
}

Failure mapToFailure(Object e, [StackTrace? st]) {
  if (e is Failure) return e;
  if (e is FormatException) return Failure('The saved data could not be read (${e.message}).', e);
  final s = e.toString();
  if (s.contains('permission-denied')) return Failure('You do not have permission for this action.', e);
  if (s.contains('unavailable') || s.contains('network')) return Failure('The server is unreachable. Check the connection and try again.', e);
  return Failure('Something went wrong. Please try again.', e);
}
