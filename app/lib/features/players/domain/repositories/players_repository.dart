import '../../../../core/typedefs/typedefs.dart';
import '../entities/player.dart';
import '../entities/rating_record.dart';

abstract interface class PlayersRepository {
  Stream<List<Player>> watchPlayers();
  ResultFuture<Player> savePlayer(Player player);
  Stream<List<RatingRecord>> watchRatings();
  ResultFuture<RatingRecord> addRating(RatingRecord rating);
}
