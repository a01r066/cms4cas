/// A user-presentable failure. Datasources throw; repositories map every
/// exception to a [Failure] with [mapToFailure], so widgets only ever show
/// [displayMessage] and never raw exception text.
class Failure {
  const Failure(this.displayMessage, {this.code = 'unknown', this.cause});

  final String displayMessage;
  final String code;
  final Object? cause;

  @override
  String toString() => displayMessage;
}
