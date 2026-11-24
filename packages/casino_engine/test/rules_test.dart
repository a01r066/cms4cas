import 'package:casino_engine/casino_engine.dart';
import 'package:test/test.dart';

void main() {
  group('Credit signatures (Table 6.2)', () {
    test('Permanent \$40k needs CM/VPF + another exec', () {
      expect(Credit.checkSignatures(LineType.permanent, 40000, [CreditRole.host]).satisfied, isFalse);
      expect(Credit.checkSignatures(LineType.permanent, 40000, [CreditRole.creditManager]).satisfied, isFalse);
      expect(Credit.checkSignatures(LineType.permanent, 40000, [CreditRole.creditManager, CreditRole.host]).satisfied, isTrue);
    });
    test('Permanent \$80k needs 3 incl. a second committee member', () {
      expect(Credit.checkSignatures(LineType.permanent, 80000, [CreditRole.vpFinance, CreditRole.host, CreditRole.shiftManager]).satisfied, isFalse);
      expect(Credit.checkSignatures(LineType.permanent, 80000, [CreditRole.vpFinance, CreditRole.host, CreditRole.casinoManager]).satisfied, isTrue);
    });
    test('Permanent above \$100k needs full committee', () {
      final r = Credit.checkSignatures(LineType.permanent, 150000, [CreditRole.vpFinance, CreditRole.creditManager, CreditRole.casinoManager]);
      expect(r.satisfied, isFalse);
      expect(r.missing, contains('President'));
    });
    test('Temporary tiers', () {
      expect(Credit.checkSignatures(LineType.temporary, 8000, [CreditRole.host]).satisfied, isTrue);
      expect(Credit.checkSignatures(LineType.temporary, 20000, [CreditRole.host]).satisfied, isFalse);
      expect(Credit.checkSignatures(LineType.temporary, 40000, [CreditRole.host, CreditRole.shiftManager, CreditRole.creditManager]).satisfied, isTrue);
      expect(Credit.checkSignatures(LineType.temporary, 60000, CreditRole.values).satisfied, isFalse);
    });
    test('Duplicate signer counts once; cage director is not a credit executive', () {
      expect(Credit.checkSignatures(LineType.temporary, 20000, [CreditRole.host, CreditRole.host]).satisfied, isFalse);
      expect(Credit.checkSignatures(LineType.temporary, 5000, [CreditRole.cageDirector]).satisfied, isFalse);
    });
    test('Write-off needs two authorized roles (p.105)', () {
      expect(Credit.writeOffApproved([CreditRole.creditManager]), isFalse);
      expect(Credit.writeOffApproved([CreditRole.creditManager, CreditRole.cageDirector]), isTrue);
      expect(Credit.writeOffApproved([CreditRole.host, CreditRole.creditManager]), isFalse);
    });
  });

  group('Credit authorization flow (Fig 6.4)', () {
    const clean = CreditCheckAnswers(applicationComplete: true, applicationLegible: true, amountRequested: 10000,
        idCopied: true, gamingReportObtained: true, fourIn14: false, consumerReportObtained: true, consumerReportClear: true,
        creditElsewhere: false, bankCheckObtained: true, canSignAlone: true, accountOpen6Months: true, averageBalanceSupports: true);
    test('Clean new applicant reaches decision via steps 23–27', () {
      final r = CreditAuthorizationFlow.evaluate(clean);
      expect(r.outcome, CreditOutcome.readyForDecision);
      expect(r.path.map((s) => s.number), containsAll([23, 24, 25, 26, 27]));
    });
    test('Incomplete stops at step 1', () {
      final r = CreditAuthorizationFlow.evaluate(const CreditCheckAnswers(applicationComplete: false, applicationLegible: true,
          amountRequested: 1, idCopied: true, gamingReportObtained: true, fourIn14: false, consumerReportObtained: false,
          consumerReportClear: false, creditElsewhere: false));
      expect(r.outcome, CreditOutcome.incomplete);
      expect(r.path.length, 1);
    });
    test('4 in 14 refers to credit manager', () {
      final r = CreditAuthorizationFlow.evaluate(CreditCheckAnswers(applicationComplete: true, applicationLegible: true,
          amountRequested: 10000, idCopied: true, gamingReportObtained: true, fourIn14: true, consumerReportObtained: true,
          consumerReportClear: true, creditElsewhere: false, bankCheckObtained: true, canSignAlone: true,
          accountOpen6Months: true, averageBalanceSupports: true));
      expect(r.outcome, CreditOutcome.referToCreditManager);
    });
    test('Owed derogs → do not issue', () {
      final r = CreditAuthorizationFlow.evaluate(const CreditCheckAnswers(applicationComplete: true, applicationLegible: true,
          amountRequested: 10000, idCopied: true, gamingReportObtained: true, fourIn14: false, consumerReportObtained: true,
          consumerReportClear: true, creditElsewhere: true, inTransitRequested: true, bankCheckObtained: true,
          canSignAlone: true, accountOpen6Months: true, averageBalanceSupports: true, hasDerogs: true, derogsPaid: false));
      expect(r.outcome, CreditOutcome.doNotIssue);
    });
    test('After hours, no bank info at Central → proceed with caution', () {
      final r = CreditAuthorizationFlow.evaluate(const CreditCheckAnswers(applicationComplete: true, applicationLegible: true,
          amountRequested: 10000, idCopied: true, gamingReportObtained: true, fourIn14: false, consumerReportObtained: true,
          consumerReportClear: true, creditElsewhere: true, inTransitRequested: true, afterBankingHours: true));
      expect(r.outcome, CreditOutcome.proceedWithCaution);
    });
  });

  group('AML aggregation (Ch5)', () {
    final t0 = DateTime(2026, 11, 24, 20);
    CashTx tx(String id, CashTxType t, double a, {int min = 0, String? visit, String patron = 'P1', String area = 'BJ-12'}) =>
        CashTx(id: id, patronKey: patron, type: t, amount: a, area: area, at: t0.add(Duration(minutes: min)), visitId: visit);

    test('Single visit rule: \$4k + \$4k chips + \$4k losing wager at one table → \$12k reportable (p.71)', () {
      final r = Aml.aggregate([
        tx('a', CashTxType.chipPurchase, 4000, visit: 'v1'),
        tx('b', CashTxType.chipPurchase, 4000, min: 10, visit: 'v1'),
        tx('c', CashTxType.losingCashWager, 4000, min: 20, visit: 'v1'),
      ], AmlProfile.bookNevada2003);
      final sv = r.firstWhere((a) => a.basis == AggBasis.singleVisit);
      expect(sv.total, 12000);
      expect(sv.reportable, isTrue);
      final chips = r.firstWhere((a) => a.basis == AggBasis.likeKind && a.label.startsWith('Chip'));
      expect(chips.total, 8000);
      expect(chips.reportable, isFalse);
    });
    test('Without single visit only like-kind aggregates → no report (p.71)', () {
      final r = Aml.aggregate([
        tx('a', CashTxType.chipPurchase, 4000),
        tx('b', CashTxType.chipPurchase, 4000, min: 10),
        tx('c', CashTxType.losingCashWager, 4000, min: 20),
      ], AmlProfile.bookNevada2003);
      expect(r.any((a) => a.reportable), isFalse);
    });
    test('Title 31: \$5,000 front money + \$5,001 chips → report (p.74)', () {
      final r = Aml.aggregate([
        tx('a', CashTxType.frontMoneyDeposit, 5000, area: 'Cage'),
        tx('b', CashTxType.chipPurchase, 5001, min: 30),
      ], const AmlProfile(regime: AggregationRegime.title31));
      expect(r.single.total, 10001);
      expect(r.single.reportable, isTrue);
    });
    test('Cash-in never combined with cash-out', () {
      final r = Aml.aggregate([
        tx('a', CashTxType.chipPurchase, 6000),
        tx('b', CashTxType.chipRedemption, 6000, min: 60),
      ], const AmlProfile(regime: AggregationRegime.title31));
      expect(r.length, 2);
      expect(r.any((a) => a.reportable), isFalse);
    });
    test('Gaming day cutoff splits a night (p.72)', () {
      final p = const AmlProfile(regime: AggregationRegime.title31, gamingDayStartHour: 0);
      final r = Aml.aggregate([
        CashTx(id: 'a', patronKey: 'P', type: CashTxType.chipPurchase, amount: 9000, area: 'BJ', at: DateTime(2026, 11, 24, 23)),
        CashTx(id: 'b', patronKey: 'P', type: CashTxType.chipPurchase, amount: 9000, area: 'BJ', at: DateTime(2026, 11, 25, 1)),
      ], p);
      expect(r.length, 2);
    });
    test('MTL: two \$2,000 jackpots same patron → log (p.63)', () {
      final first = tx('a', CashTxType.jackpotPayout, 2000);
      final second = tx('b', CashTxType.jackpotPayout, 2000, min: 60);
      expect(Aml.needsMtlEntry(first, [], AmlProfile.bookNevada2003), isFalse);
      expect(Aml.needsMtlEntry(second, [first], AmlProfile.bookNevada2003), isTrue);
    });
    test('Prohibited transactions and SAR due date', () {
      expect(Aml.prohibited(profile: AmlProfile.bookNevada2003, kind: 'cash_for_cash', amount: 3500), isNotNull);
      expect(Aml.prohibited(profile: AmlProfile.bookNevada2003, kind: 'casino_check_for_cash', amount: 50000, verifiedWinnings: true), isNull);
      expect(Aml.sarDueDate(DateTime(2026, 1, 1), AmlProfile.bookNevada2003), DateTime(2026, 1, 31));
      expect(Aml.sarDueDate(DateTime(2026, 1, 1), AmlProfile.bookNevada2003, extended: true), DateTime(2026, 3, 2));
    });
  });

  group('Comps', () {
    test('Quick loss beats theo basis', () {
      final r = Comps.allowance(theo: 1000, actualLoss: 100000);
      expect(r.allowance, 15000);
    });
    test('Theo basis otherwise', () {
      expect(Comps.allowance(theo: 1000, actualLoss: 0).allowance, 450);
    });
  });
}
