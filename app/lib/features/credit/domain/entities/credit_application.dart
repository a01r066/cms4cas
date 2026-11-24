import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'credit_enums.dart';
import 'signature.dart';

part 'credit_application.freezed.dart';

const kDefaultDisposition = 'Statement to residence — pay within 30 days of last marker';

/// Fig 6.4 walkthrough → assessment → Table 6.2 signatures → decision (Ch6).
@freezed
abstract class CreditApplication with _$CreditApplication {
  const CreditApplication._();

  const factory CreditApplication({
    required String id,
    required String playerId,
    required String createdBy,
    required LineType lineType,
    required double amount,
    required CreditStatus status,
    required DateTime createdAt,
    @Default(kDefaultDisposition) String disposition,
    @Default(<String, bool>{}) Map<String, bool> answers,
    CreditOutcome? outcome,
    @Default(<String>[]) List<String> referrals,
    @Default(<Signature>[]) List<Signature> signatures,
    DateTime? decidedAt,
    @Default('') String declineReason,
  }) = _CreditApplication;

  SignatureCheck get signatureCheck => Credit.checkSignatures(lineType, amount, signatures.map((s) => s.role).toList());

  bool get hasCreditManagerSignature => signatures.any((s) => s.role == CreditRole.creditManager);

  /// Same rule the server applies in decideCreditApplication.
  bool get canApprove =>
      status == CreditStatus.pendingApproval &&
      outcome != null &&
      outcome!.allowsApproval &&
      signatureCheck.satisfied &&
      (outcome != CreditOutcome.referToCreditManager || hasCreditManagerSignature);

  bool signedBy(String userId) => signatures.any((s) => s.userId == userId);

  CreditCheckAnswers checkAnswers([Map<String, bool>? override]) {
    final m = override ?? answers;
    bool b(String k) => m[k] ?? false;
    return CreditCheckAnswers(
      applicationComplete: b('applicationComplete'),
      applicationLegible: b('applicationLegible'),
      amountRequested: amount,
      idCopied: b('idCopied'),
      gamingReportObtained: b('gamingReportObtained'),
      fourIn14: b('fourIn14'),
      consumerReportObtained: b('consumerReportObtained'),
      consumerReportClear: b('consumerReportClear'),
      creditElsewhere: b('creditElsewhere'),
      inTransitRequested: b('inTransitRequested'),
      customerOwes: b('customerOwes'),
      afterBankingHours: b('afterBankingHours'),
      bankCheckObtained: b('bankCheckObtained'),
      canSignAlone: b('canSignAlone'),
      accountOpen6Months: b('accountOpen6Months'),
      averageBalanceSupports: b('averageBalanceSupports'),
      hasDerogs: b('hasDerogs'),
      derogsPaid: b('derogsPaid'),
      bankInfoAtCentral: b('bankInfoAtCentral'),
      currentLimitEqualsRequest: b('currentLimitEqualsRequest'),
    );
  }
}
