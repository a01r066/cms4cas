import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/rating_record.dart';

part 'rating_record_model.freezed.dart';
part 'rating_record_model.g.dart';

/// casinos/{casinoId}/ratings/{id}
@freezed
abstract class RatingRecordModel with _$RatingRecordModel {
  const RatingRecordModel._();

  const factory RatingRecordModel({
    required String id,
    @Default('') String playerId,
    @Default('') String gameId,
    @Default('') String gameName,
    @Default('') String table,
    @Default('') String ratedBy,
    @Default(0) double averageBet,
    @Default(0) double minutes,
    @Default(0) double decisionsPerHour,
    @Default(0) double effectiveAdvantage,
    @Default(0) double theo,
    @Default(0) double actualCasinoWin,
    @Default(0) double sd,
    @Default(1) int players,
    @Default('average') String type,
    required DateTime at,
  }) = _RatingRecordModel;

  factory RatingRecordModel.fromJson(Map<String, dynamic> json) => _$RatingRecordModelFromJson(json);

  factory RatingRecordModel.fromEntity(RatingRecord r) => RatingRecordModel(
        id: r.id,
        playerId: r.playerId,
        gameId: r.gameId,
        gameName: r.gameName,
        table: r.table,
        ratedBy: r.ratedBy,
        averageBet: r.averageBet,
        minutes: r.minutes,
        decisionsPerHour: r.decisionsPerHour,
        effectiveAdvantage: r.effectiveAdvantage,
        theo: r.theo,
        actualCasinoWin: r.actualCasinoWin,
        sd: r.sd,
        players: r.players,
        type: r.type.wire,
        at: r.at,
      );

  RatingRecord toEntity() => RatingRecord(
        id: id,
        playerId: playerId,
        gameId: gameId,
        gameName: gameName,
        table: table,
        ratedBy: ratedBy,
        averageBet: averageBet,
        minutes: minutes,
        decisionsPerHour: decisionsPerHour,
        effectiveAdvantage: effectiveAdvantage,
        theo: theo,
        actualCasinoWin: actualCasinoWin,
        sd: sd,
        players: players,
        type: PlayerType.fromWire(type),
        at: at,
      );
}
