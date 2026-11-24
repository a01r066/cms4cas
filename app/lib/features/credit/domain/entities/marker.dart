import 'package:freezed_annotation/freezed_annotation.dart';

import 'credit_enums.dart';
import 'signature.dart';

part 'marker.freezed.dart';

@freezed
abstract class MarkerPayment with _$MarkerPayment {
  const factory MarkerPayment({
    required double amount,
    /// Cash, Cheques (in pit), Check, Wire.
    required String method,
    required String recordedBy,
    required DateTime at,
  }) = _MarkerPayment;
}

/// Counter check signed at the table (Ch9 p.169). Settlement and write-off per Ch6 pp.104–105.
@freezed
abstract class Marker with _$Marker {
  const Marker._();

  const factory Marker({
    required String id,
    required String playerId,
    required String number,
    required String table,
    required String issuedBy,
    required double amount,
    required DateTime issuedAt,
    @Default(<MarkerPayment>[]) List<MarkerPayment> payments,
    @Default(MarkerStatus.open) MarkerStatus status,
    @Default(0) double writeOffAmount,
    @Default('') String writeOffReason,
    @Default(<Signature>[]) List<Signature> writeOffSignatures,
    @Default('') String collectionNote,
  }) = _Marker;

  double get paid => payments.fold(0, (a, p) => a + p.amount);
  double get balance => status == MarkerStatus.open ? (amount - paid).clamp(0, double.infinity).toDouble() : 0;
  int ageDays([DateTime? now]) => (now ?? DateTime.now()).difference(issuedAt).inDays;
}
