import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/credit_application.dart';
import '../../domain/entities/credit_enums.dart';
import '../../domain/entities/marker.dart';
import '../../domain/entities/signature.dart';

part 'credit_models.freezed.dart';
part 'credit_models.g.dart';

@freezed
abstract class SignatureModel with _$SignatureModel {
  const SignatureModel._();

  const factory SignatureModel({
    required String userId,
    @Default('') String userName,
    @Default('host') String role,
    required DateTime at,
  }) = _SignatureModel;

  factory SignatureModel.fromJson(Map<String, dynamic> json) => _$SignatureModelFromJson(json);

  factory SignatureModel.fromEntity(Signature s) =>
      SignatureModel(userId: s.userId, userName: s.userName, role: s.role.wire, at: s.at);

  Signature toEntity() =>
      Signature(userId: userId, userName: userName, role: CreditRole.fromWire(role) ?? CreditRole.host, at: at);
}

/// casinos/{casinoId}/credit_applications/{id}
@freezed
abstract class CreditApplicationModel with _$CreditApplicationModel {
  const CreditApplicationModel._();

  const factory CreditApplicationModel({
    required String id,
    @Default('') String playerId,
    @Default('') String createdBy,
    @Default('permanent') String lineType,
    @Default(0) double amount,
    @Default('draft') String status,
    @Default(kDefaultDisposition) String disposition,
    @Default(<String, bool>{}) Map<String, bool> answers,
    String? outcome,
    @Default(<String>[]) List<String> referrals,
    @Default(<SignatureModel>[]) List<SignatureModel> signatures,
    required DateTime createdAt,
    DateTime? decidedAt,
    @Default('') String declineReason,
  }) = _CreditApplicationModel;

  factory CreditApplicationModel.fromJson(Map<String, dynamic> json) => _$CreditApplicationModelFromJson(json);

  factory CreditApplicationModel.fromEntity(CreditApplication a) => CreditApplicationModel(
        id: a.id,
        playerId: a.playerId,
        createdBy: a.createdBy,
        lineType: a.lineType.wire,
        amount: a.amount,
        status: a.status.wire,
        disposition: a.disposition,
        answers: a.answers,
        outcome: a.outcome?.wire,
        referrals: a.referrals,
        signatures: a.signatures.map(SignatureModel.fromEntity).toList(),
        createdAt: a.createdAt,
        decidedAt: a.decidedAt,
        declineReason: a.declineReason,
      );

  CreditApplication toEntity() => CreditApplication(
        id: id,
        playerId: playerId,
        createdBy: createdBy,
        lineType: LineType.fromWire(lineType),
        amount: amount,
        status: CreditStatus.fromWire(status),
        createdAt: createdAt,
        disposition: disposition,
        answers: answers,
        outcome: CreditOutcome.fromWire(outcome),
        referrals: referrals,
        signatures: signatures.map((s) => s.toEntity()).toList(),
        decidedAt: decidedAt,
        declineReason: declineReason,
      );
}

@freezed
abstract class MarkerPaymentModel with _$MarkerPaymentModel {
  const MarkerPaymentModel._();

  const factory MarkerPaymentModel({
    @Default(0) double amount,
    @Default('') String method,
    @Default('') String recordedBy,
    required DateTime at,
  }) = _MarkerPaymentModel;

  factory MarkerPaymentModel.fromJson(Map<String, dynamic> json) => _$MarkerPaymentModelFromJson(json);

  factory MarkerPaymentModel.fromEntity(MarkerPayment p) =>
      MarkerPaymentModel(amount: p.amount, method: p.method, recordedBy: p.recordedBy, at: p.at);

  MarkerPayment toEntity() => MarkerPayment(amount: amount, method: method, recordedBy: recordedBy, at: at);
}

/// casinos/{casinoId}/markers/{id} — created and changed only by privileged actions,
/// except [collectionNote].
@freezed
abstract class MarkerModel with _$MarkerModel {
  const MarkerModel._();

  const factory MarkerModel({
    required String id,
    @Default('') String playerId,
    @Default('') String number,
    @Default('') String table,
    @Default('') String issuedBy,
    @Default(0) double amount,
    required DateTime issuedAt,
    @Default(<MarkerPaymentModel>[]) List<MarkerPaymentModel> payments,
    @Default('open') String status,
    @Default(0) double writeOffAmount,
    @Default('') String writeOffReason,
    @Default(<SignatureModel>[]) List<SignatureModel> writeOffSignatures,
    @Default('') String collectionNote,
  }) = _MarkerModel;

  factory MarkerModel.fromJson(Map<String, dynamic> json) => _$MarkerModelFromJson(json);

  factory MarkerModel.fromEntity(Marker m) => MarkerModel(
        id: m.id,
        playerId: m.playerId,
        number: m.number,
        table: m.table,
        issuedBy: m.issuedBy,
        amount: m.amount,
        issuedAt: m.issuedAt,
        payments: m.payments.map(MarkerPaymentModel.fromEntity).toList(),
        status: m.status.wire,
        writeOffAmount: m.writeOffAmount,
        writeOffReason: m.writeOffReason,
        writeOffSignatures: m.writeOffSignatures.map(SignatureModel.fromEntity).toList(),
        collectionNote: m.collectionNote,
      );

  Marker toEntity() => Marker(
        id: id,
        playerId: playerId,
        number: number,
        table: table,
        issuedBy: issuedBy,
        amount: amount,
        issuedAt: issuedAt,
        payments: payments.map((p) => p.toEntity()).toList(),
        status: MarkerStatus.fromWire(status),
        writeOffAmount: writeOffAmount,
        writeOffReason: writeOffReason,
        writeOffSignatures: writeOffSignatures.map((s) => s.toEntity()).toList(),
        collectionNote: collectionNote,
      );
}
