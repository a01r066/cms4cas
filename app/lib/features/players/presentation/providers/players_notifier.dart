import 'package:casino_engine/casino_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/util/ids.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/rating_record.dart';
import '../../domain/repositories/players_repository.dart';
import 'players_providers.dart';
import 'players_state.dart';

/// Player profiles and rated sessions.
class PlayersNotifier extends StateNotifier<PlayersState> {
  PlayersNotifier(this._repo, this._user) : super(const PlayersState());

  final PlayersRepository _repo;
  final AppUser? Function() _user;

  /// New player when [existing] is null; keeps who/when it was created otherwise.
  ResultFuture<Player> savePlayer({
    Player? existing,
    required String name,
    String playerNo = '',
    String idDocument = '',
    String address = '',
    String notes = '',
  }) {
    final p = Player(
      id: existing?.id ?? newId(),
      name: name.trim(),
      playerNo: playerNo.trim(),
      idDocument: idDocument.trim(),
      address: address.trim(),
      notes: notes.trim(),
      createdBy: existing?.createdBy ?? (_user()?.name ?? ''),
      createdAt: existing?.createdAt ?? DateTime.now(),
    );
    return _run(() => _repo.savePlayer(p));
  }

  /// Saves a rating with the theo computed from the book formula at this moment.
  ResultFuture<RatingRecord> rateSession({
    required String playerId,
    required GameRatingParams game,
    required RatingResult result,
    required double averageBet,
    required double minutes,
    required int players,
    required PlayerType type,
    String table = '',
    double actualCasinoWin = 0,
  }) {
    final user = _user();
    if (user == null) return Future.value(const Left(Failure('Sign in first.', code: 'unauthenticated')));
    final rec = RatingRecord(
      id: newId(),
      playerId: playerId,
      gameId: game.id,
      gameName: game.name,
      table: table.trim(),
      ratedBy: user.name,
      averageBet: averageBet,
      minutes: minutes,
      decisionsPerHour: result.decisionsPerHour,
      effectiveAdvantage: result.effectiveAdvantage,
      theo: result.theoreticalWin,
      actualCasinoWin: actualCasinoWin,
      sd: result.sd,
      players: players,
      type: type,
      at: DateTime.now(),
    );
    return _run(() => _repo.addRating(rec));
  }

  ResultFuture<T> _run<T>(ResultFuture<T> Function() f) async {
    state = state.copyWith(saving: true, failure: null);
    final r = await f();
    if (mounted) state = r.fold((f) => state.copyWith(saving: false, failure: f), (_) => state.copyWith(saving: false));
    return r;
  }
}

final playersNotifierProvider = StateNotifierProvider<PlayersNotifier, PlayersState>(
  (ref) => PlayersNotifier(ref.watch(playersRepositoryProvider), () => ref.read(currentUserValueProvider)),
);
