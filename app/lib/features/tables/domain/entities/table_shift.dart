import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_shift.freezed.dart';

/// One shift (or gaming day) of a table: opener, fills/credits, drop-box contents, closer (Ch9).
@freezed
abstract class TableShift with _$TableShift {
  const TableShift._();

  const factory TableShift({
    required String id,
    required String tableId,
    required String shift,
    required String recordedBy,
    required DateTime gamingDay,
    required DateTime recordedAt,
    required TableShiftInput input,
  }) = _TableShift;

  /// Win = drop − (opener + fills − credits − closer); hold = win ÷ drop.
  TableShiftResult get result => TableGames.compute(input);
}
