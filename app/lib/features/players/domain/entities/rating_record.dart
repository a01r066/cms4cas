import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_record.freezed.dart';

/// One rated session (Ch12 rating card, Fig 12.1). Theo and SD are stored as
/// computed at the time, so later settings changes never rewrite history.
@freezed
abstract class RatingRecord with _$RatingRecord {
  const RatingRecord._();

  const factory RatingRecord({
    required String id,
    required String playerId,
    required String gameId,
    required String gameName,
    @Default('') String table,
    required String ratedBy,
    required double averageBet,
    required double minutes,
    required double decisionsPerHour,
    required double effectiveAdvantage,
    required double theo,
    @Default(0) double actualCasinoWin,
    required double sd,
    required int players,
    required PlayerType type,
    required DateTime at,
  }) = _RatingRecord;

  double get hours => minutes / 60;
}
