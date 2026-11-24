import '../../../../core/storage/record_store.dart';
import '../models/player_model.dart';
import '../models/rating_record_model.dart';

class PlayersRemoteDataSource {
  PlayersRemoteDataSource(this._store);

  final RecordStore _store;

  static const players = 'players';
  static const ratings = 'ratings';

  Stream<List<PlayerModel>> watchPlayers() => _store.watch(players).map((l) => l.map(PlayerModel.fromJson).toList());

  Future<void> savePlayer(PlayerModel m) => _store.put(players, m.id, m.toJson());

  Stream<List<RatingRecordModel>> watchRatings() => _store.watch(ratings).map((l) => l.map(RatingRecordModel.fromJson).toList());

  /// Ratings are append-only for non-admins (rules).
  Future<void> addRating(RatingRecordModel m) => _store.put(ratings, m.id, m.toJson());
}
