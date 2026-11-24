import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_entities.freezed.dart';

/// A logged cash transaction (MTL entry). Append-only.
@freezed
abstract class CashTxRecord with _$CashTxRecord {
  const CashTxRecord._();

  const factory CashTxRecord({
    required String id,
    /// Player id, or `desc:<description>` for an unidentified patron.
    required String patronKey,
    required String patronLabel,
    required String area,
    required String recordedBy,
    required CashTxType type,
    required double amount,
    required DateTime at,
    /// Continuous appearance at one location (single-visit rule, p.71).
    String? visitId,
  }) = _CashTxRecord;

  CashTx get tx => CashTx(id: id, patronKey: patronKey, type: type, amount: amount, area: area, at: at, visitId: visitId);
}

enum CtrStatus {
  draft('draft', 'Draft'),
  prepared('prepared', 'Prepared'),
  reviewed('reviewed', 'Reviewed'),
  filed('filed', 'Filed');

  const CtrStatus(this.wire, this.label);
  final String wire, label;

  static CtrStatus fromWire(String? w) => values.firstWhere((s) => s.wire == w, orElse: () => draft);
}

/// Currency transaction report. Preparer and reviewer must be different people.
@freezed
abstract class CtrReport with _$CtrReport {
  const CtrReport._();

  const factory CtrReport({
    required String id,
    required String patronKey,
    required String patronLabel,
    required String aggregateLabel,
    required String direction,
    required DateTime gamingDay,
    required double total,
    required List<String> txIds,
    @Default(<String, bool>{}) Map<String, bool> fields,
    @Default(CtrStatus.draft) CtrStatus status,
    @Default('') String preparedBy,
    @Default('') String preparedById,
    @Default('') String reviewedBy,
    @Default('') String reviewedById,
    DateTime? filedAt,
  }) = _CtrReport;

  /// "Filed as a result of multiple transactions" box (p.68).
  bool get multiple => txIds.length > 1;

  /// The patron-identification fields must be completed before preparing.
  bool get complete => Aml.ctrRequiredFields.take(8).every((f) => fields[f] == true);
}

@freezed
abstract class BarredPatron with _$BarredPatron {
  const factory BarredPatron({
    required String id,
    required String description,
    required String reason,
    @Default('') String playerId,
    @Default('') String addedBy,
    required DateTime since,
    @Default(true) bool active,
  }) = _BarredPatron;
}

@freezed
abstract class SarCase with _$SarCase {
  const SarCase._();

  const factory SarCase({
    required String id,
    required String subject,
    required String summary,
    required String openedBy,
    required double amount,
    required DateTime detectedAt,
    /// +30 days when the subject is not yet identified.
    @Default(false) bool extended,
    DateTime? filedAt,
  }) = _SarCase;

  DateTime dueDate(AmlProfile p) => Aml.sarDueDate(detectedAt, p, extended: extended);
}
