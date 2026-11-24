import 'package:dartz/dartz.dart';

import '../../../../core/error/failure_mapper.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/streams.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/rating_record.dart';
import '../../domain/repositories/players_repository.dart';
import '../datasources/players_remote_datasource.dart';
import '../models/player_model.dart';
import '../models/rating_record_model.dart';

class PlayersRepositoryImpl implements PlayersRepository {
  PlayersRepositoryImpl(this._ds);

  final PlayersRemoteDataSource _ds;

  @override
  Stream<List<Player>> watchPlayers() => _ds
      .watchPlayers()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())))
      .mapErrorsToFailure();

  @override
  ResultFuture<Player> savePlayer(Player player) async {
    try {
      await _ds.savePlayer(PlayerModel.fromEntity(player));
      return Right(player);
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }

  @override
  Stream<List<RatingRecord>> watchRatings() => _ds
      .watchRatings()
      .map((l) => l.map((m) => m.toEntity()).toList()..sort((a, b) => b.at.compareTo(a.at)))
      .mapErrorsToFailure();

  @override
  ResultFuture<RatingRecord> addRating(RatingRecord rating) async {
    try {
      await _ds.addRating(RatingRecordModel.fromEntity(rating));
      return Right(rating);
    } catch (e, st) {
      return Left(mapToFailure(e, st));
    }
  }
}
