import 'package:dartz/dartz.dart';

import '../error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = ResultFuture<Unit>;
typedef Json = Map<String, dynamic>;
