import 'package:freezed_annotation/freezed_annotation.dart';

part 'hit_record.freezed.dart';

/// A documented large player result removed from adjusted hold (Ch13 p.249).
@freezed
abstract class HitRecord with _$HitRecord {
  const factory HitRecord({
    required String id,
    required String tableId,
    required String playerLabel,
    required DateTime gamingDay,
    required double playerDrop,
    required double casinoResult,
    @Default('') String note,
    @Default('') String recordedBy,
  }) = _HitRecord;
}
