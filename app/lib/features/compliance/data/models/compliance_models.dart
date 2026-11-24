import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/compliance_entities.dart';

part 'compliance_models.freezed.dart';
part 'compliance_models.g.dart';

/// casinos/{casinoId}/cash_transactions/{id}
@freezed
abstract class CashTxModel with _$CashTxModel {
  const CashTxModel._();

  const factory CashTxModel({
    required String id,
    @Default('') String patronKey,
    @Default('') String patronLabel,
    @Default('') String area,
    @Default('') String recordedBy,
    @Default('') String type,
    @Default(0) double amount,
    required DateTime at,
    String? visitId,
  }) = _CashTxModel;

  factory CashTxModel.fromJson(Map<String, dynamic> json) => _$CashTxModelFromJson(json);

  factory CashTxModel.fromEntity(CashTxRecord r) => CashTxModel(
      id: r.id, patronKey: r.patronKey, patronLabel: r.patronLabel, area: r.area, recordedBy: r.recordedBy,
      type: r.type.wire, amount: r.amount, at: r.at, visitId: r.visitId);

  CashTxRecord toEntity() => CashTxRecord(
      id: id, patronKey: patronKey, patronLabel: patronLabel, area: area, recordedBy: recordedBy,
      type: CashTxType.fromWire(type), amount: amount, at: at, visitId: visitId);
}

/// casinos/{casinoId}/ctr_reports/{id}
@freezed
abstract class CtrReportModel with _$CtrReportModel {
  const CtrReportModel._();

  const factory CtrReportModel({
    required String id,
    @Default('') String patronKey,
    @Default('') String patronLabel,
    @Default('') String aggregateLabel,
    @Default('') String direction,
    required DateTime gamingDay,
    @Default(0) double total,
    @Default(<String>[]) List<String> txIds,
    @Default(<String, bool>{}) Map<String, bool> fields,
    @Default('draft') String status,
    @Default('') String preparedBy,
    @Default('') String preparedById,
    @Default('') String reviewedBy,
    @Default('') String reviewedById,
    DateTime? filedAt,
  }) = _CtrReportModel;

  factory CtrReportModel.fromJson(Map<String, dynamic> json) => _$CtrReportModelFromJson(json);

  factory CtrReportModel.fromEntity(CtrReport r) => CtrReportModel(
      id: r.id, patronKey: r.patronKey, patronLabel: r.patronLabel, aggregateLabel: r.aggregateLabel, direction: r.direction,
      gamingDay: r.gamingDay, total: r.total, txIds: r.txIds, fields: r.fields, status: r.status.wire, preparedBy: r.preparedBy,
      preparedById: r.preparedById, reviewedBy: r.reviewedBy, reviewedById: r.reviewedById, filedAt: r.filedAt);

  CtrReport toEntity() => CtrReport(
      id: id, patronKey: patronKey, patronLabel: patronLabel, aggregateLabel: aggregateLabel, direction: direction,
      gamingDay: gamingDay, total: total, txIds: txIds, fields: fields, status: CtrStatus.fromWire(status), preparedBy: preparedBy,
      preparedById: preparedById, reviewedBy: reviewedBy, reviewedById: reviewedById, filedAt: filedAt);
}

/// casinos/{casinoId}/barred_patrons/{id}
@freezed
abstract class BarredPatronModel with _$BarredPatronModel {
  const BarredPatronModel._();

  const factory BarredPatronModel({
    required String id,
    @Default('') String description,
    @Default('') String reason,
    @Default('') String playerId,
    @Default('') String addedBy,
    required DateTime since,
    @Default(true) bool active,
  }) = _BarredPatronModel;

  factory BarredPatronModel.fromJson(Map<String, dynamic> json) => _$BarredPatronModelFromJson(json);

  factory BarredPatronModel.fromEntity(BarredPatron b) => BarredPatronModel(
      id: b.id, description: b.description, reason: b.reason, playerId: b.playerId, addedBy: b.addedBy, since: b.since, active: b.active);

  BarredPatron toEntity() =>
      BarredPatron(id: id, description: description, reason: reason, playerId: playerId, addedBy: addedBy, since: since, active: active);
}

/// casinos/{casinoId}/sar_cases/{id} — restricted read.
@freezed
abstract class SarCaseModel with _$SarCaseModel {
  const SarCaseModel._();

  const factory SarCaseModel({
    required String id,
    @Default('') String subject,
    @Default('') String summary,
    @Default('') String openedBy,
    @Default(0) double amount,
    required DateTime detectedAt,
    @Default(false) bool extended,
    DateTime? filedAt,
  }) = _SarCaseModel;

  factory SarCaseModel.fromJson(Map<String, dynamic> json) => _$SarCaseModelFromJson(json);

  factory SarCaseModel.fromEntity(SarCase s) => SarCaseModel(
      id: s.id, subject: s.subject, summary: s.summary, openedBy: s.openedBy, amount: s.amount, detectedAt: s.detectedAt,
      extended: s.extended, filedAt: s.filedAt);

  SarCase toEntity() => SarCase(
      id: id, subject: subject, summary: summary, openedBy: openedBy, amount: amount, detectedAt: detectedAt,
      extended: extended, filedAt: filedAt);
}
