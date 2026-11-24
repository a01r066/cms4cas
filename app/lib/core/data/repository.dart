import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import '../error/failure.dart';
import '../typedefs/typedefs.dart';
import 'record_store.dart';

/// Typed repository over one collection. Store throws; repository returns Either.
class Repository<T> {
  final RecordStore store;
  final String collection;
  final T Function(Json) fromJson;
  final Json Function(T) toJson;
  Repository(this.store, this.collection, this.fromJson, this.toJson);

  static String newId() => const Uuid().v4();

  Stream<List<T>> watch() => store.watch(collection).map((l) => l.map(fromJson).toList());

  ResultFuture<List<T>> list() async {
    try {
      return Right((await store.list(collection)).map(fromJson).toList());
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  ResultFuture<T?> get(String id) async {
    try {
      final j = await store.get(collection, id);
      return Right(j == null ? null : fromJson(j));
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  ResultFuture<T> save(String id, T value) async {
    try {
      await store.put(collection, id, toJson(value));
      return Right(value);
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  ResultFuture<Unit> remove(String id) async {
    try {
      await store.delete(collection, id);
      return const Right(unit);
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }
}
