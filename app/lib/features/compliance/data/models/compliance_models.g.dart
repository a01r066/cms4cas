// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CashTxModel _$CashTxModelFromJson(Map<String, dynamic> json) => _CashTxModel(
  id: json['id'] as String,
  patronKey: json['patronKey'] as String? ?? '',
  patronLabel: json['patronLabel'] as String? ?? '',
  area: json['area'] as String? ?? '',
  recordedBy: json['recordedBy'] as String? ?? '',
  type: json['type'] as String? ?? '',
  amount: (json['amount'] as num?)?.toDouble() ?? 0,
  at: DateTime.parse(json['at'] as String),
  visitId: json['visitId'] as String?,
);

Map<String, dynamic> _$CashTxModelToJson(_CashTxModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patronKey': instance.patronKey,
      'patronLabel': instance.patronLabel,
      'area': instance.area,
      'recordedBy': instance.recordedBy,
      'type': instance.type,
      'amount': instance.amount,
      'at': instance.at.toIso8601String(),
      'visitId': instance.visitId,
    };

_CtrReportModel _$CtrReportModelFromJson(Map<String, dynamic> json) =>
    _CtrReportModel(
      id: json['id'] as String,
      patronKey: json['patronKey'] as String? ?? '',
      patronLabel: json['patronLabel'] as String? ?? '',
      aggregateLabel: json['aggregateLabel'] as String? ?? '',
      direction: json['direction'] as String? ?? '',
      gamingDay: DateTime.parse(json['gamingDay'] as String),
      total: (json['total'] as num?)?.toDouble() ?? 0,
      txIds:
          (json['txIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      fields:
          (json['fields'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const <String, bool>{},
      status: json['status'] as String? ?? 'draft',
      preparedBy: json['preparedBy'] as String? ?? '',
      preparedById: json['preparedById'] as String? ?? '',
      reviewedBy: json['reviewedBy'] as String? ?? '',
      reviewedById: json['reviewedById'] as String? ?? '',
      filedAt: json['filedAt'] == null
          ? null
          : DateTime.parse(json['filedAt'] as String),
    );

Map<String, dynamic> _$CtrReportModelToJson(_CtrReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patronKey': instance.patronKey,
      'patronLabel': instance.patronLabel,
      'aggregateLabel': instance.aggregateLabel,
      'direction': instance.direction,
      'gamingDay': instance.gamingDay.toIso8601String(),
      'total': instance.total,
      'txIds': instance.txIds,
      'fields': instance.fields,
      'status': instance.status,
      'preparedBy': instance.preparedBy,
      'preparedById': instance.preparedById,
      'reviewedBy': instance.reviewedBy,
      'reviewedById': instance.reviewedById,
      'filedAt': instance.filedAt?.toIso8601String(),
    };

_BarredPatronModel _$BarredPatronModelFromJson(Map<String, dynamic> json) =>
    _BarredPatronModel(
      id: json['id'] as String,
      description: json['description'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
      playerId: json['playerId'] as String? ?? '',
      addedBy: json['addedBy'] as String? ?? '',
      since: DateTime.parse(json['since'] as String),
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$BarredPatronModelToJson(_BarredPatronModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'reason': instance.reason,
      'playerId': instance.playerId,
      'addedBy': instance.addedBy,
      'since': instance.since.toIso8601String(),
      'active': instance.active,
    };

_SarCaseModel _$SarCaseModelFromJson(Map<String, dynamic> json) =>
    _SarCaseModel(
      id: json['id'] as String,
      subject: json['subject'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      openedBy: json['openedBy'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      detectedAt: DateTime.parse(json['detectedAt'] as String),
      extended: json['extended'] as bool? ?? false,
      filedAt: json['filedAt'] == null
          ? null
          : DateTime.parse(json['filedAt'] as String),
    );

Map<String, dynamic> _$SarCaseModelToJson(_SarCaseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'summary': instance.summary,
      'openedBy': instance.openedBy,
      'amount': instance.amount,
      'detectedAt': instance.detectedAt.toIso8601String(),
      'extended': instance.extended,
      'filedAt': instance.filedAt?.toIso8601String(),
    };
