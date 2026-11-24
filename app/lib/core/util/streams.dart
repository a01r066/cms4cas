import 'dart:async';

import '../error/failure_mapper.dart';

extension FailureStream<T> on Stream<T> {
  /// Repository streams surface errors as [Failure]s, like repository futures.
  Stream<T> mapErrorsToFailure() => transform(StreamTransformer<T, T>.fromHandlers(
        handleError: (e, st, sink) => sink.addError(mapToFailure(e, st), st),
      ));
}
