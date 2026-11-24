// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignatureModel _$SignatureModelFromJson(Map<String, dynamic> json) =>
    _SignatureModel(
      userId: json['userId'] as String,
      userName: json['userName'] as String? ?? '',
      role: json['role'] as String? ?? 'host',
      at: DateTime.parse(json['at'] as String),
    );

Map<String, dynamic> _$SignatureModelToJson(_SignatureModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'role': instance.role,
      'at': instance.at.toIso8601String(),
    };

_CreditApplicationModel _$CreditApplicationModelFromJson(
  Map<String, dynamic> json,
) => _CreditApplicationModel(
  id: json['id'] as String,
  playerId: json['playerId'] as String? ?? '',
  createdBy: json['createdBy'] as String? ?? '',
  lineType: json['lineType'] as String? ?? 'permanent',
  amount: (json['amount'] as num?)?.toDouble() ?? 0,
  status: json['status'] as String? ?? 'draft',
  disposition: json['disposition'] as String? ?? kDefaultDisposition,
  answers:
      (json['answers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      const <String, bool>{},
  outcome: json['outcome'] as String?,
  referrals:
      (json['referrals'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  signatures:
      (json['signatures'] as List<dynamic>?)
          ?.map((e) => SignatureModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SignatureModel>[],
  createdAt: DateTime.parse(json['createdAt'] as String),
  decidedAt: json['decidedAt'] == null
      ? null
      : DateTime.parse(json['decidedAt'] as String),
  declineReason: json['declineReason'] as String? ?? '',
);

Map<String, dynamic> _$CreditApplicationModelToJson(
  _CreditApplicationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'playerId': instance.playerId,
  'createdBy': instance.createdBy,
  'lineType': instance.lineType,
  'amount': instance.amount,
  'status': instance.status,
  'disposition': instance.disposition,
  'answers': instance.answers,
  'outcome': instance.outcome,
  'referrals': instance.referrals,
  'signatures': instance.signatures.map((e) => e.toJson()).toList(),
  'createdAt': instance.createdAt.toIso8601String(),
  'decidedAt': instance.decidedAt?.toIso8601String(),
  'declineReason': instance.declineReason,
};

_MarkerPaymentModel _$MarkerPaymentModelFromJson(Map<String, dynamic> json) =>
    _MarkerPaymentModel(
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      method: json['method'] as String? ?? '',
      recordedBy: json['recordedBy'] as String? ?? '',
      at: DateTime.parse(json['at'] as String),
    );

Map<String, dynamic> _$MarkerPaymentModelToJson(_MarkerPaymentModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'method': instance.method,
      'recordedBy': instance.recordedBy,
      'at': instance.at.toIso8601String(),
    };

_MarkerModel _$MarkerModelFromJson(Map<String, dynamic> json) => _MarkerModel(
  id: json['id'] as String,
  playerId: json['playerId'] as String? ?? '',
  number: json['number'] as String? ?? '',
  table: json['table'] as String? ?? '',
  issuedBy: json['issuedBy'] as String? ?? '',
  amount: (json['amount'] as num?)?.toDouble() ?? 0,
  issuedAt: DateTime.parse(json['issuedAt'] as String),
  payments:
      (json['payments'] as List<dynamic>?)
          ?.map((e) => MarkerPaymentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MarkerPaymentModel>[],
  status: json['status'] as String? ?? 'open',
  writeOffAmount: (json['writeOffAmount'] as num?)?.toDouble() ?? 0,
  writeOffReason: json['writeOffReason'] as String? ?? '',
  writeOffSignatures:
      (json['writeOffSignatures'] as List<dynamic>?)
          ?.map((e) => SignatureModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SignatureModel>[],
  collectionNote: json['collectionNote'] as String? ?? '',
);

Map<String, dynamic> _$MarkerModelToJson(_MarkerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'number': instance.number,
      'table': instance.table,
      'issuedBy': instance.issuedBy,
      'amount': instance.amount,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'payments': instance.payments.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'writeOffAmount': instance.writeOffAmount,
      'writeOffReason': instance.writeOffReason,
      'writeOffSignatures': instance.writeOffSignatures
          .map((e) => e.toJson())
          .toList(),
      'collectionNote': instance.collectionNote,
    };
