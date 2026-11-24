import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_def.freezed.dart';

/// A live gaming table. [baseHold] = prior-year statistical hold, the centre of
/// the ±tolerance band used to flag tables for investigation (Ch13).
@freezed
abstract class TableDef with _$TableDef {
  const factory TableDef({
    required String id,
    required String name,
    required String gameId,
    @Default('') String pit,
    @Default(0) double minBet,
    @Default(0) double maxBet,
    @Default(0) double baseHold,
    @Default(MarkerSystem.marker) MarkerSystem system,
  }) = _TableDef;
}
