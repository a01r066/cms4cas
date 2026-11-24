import 'book_ref.dart';

/// Roles that may sign credit decisions (Table 6.2, p.103).
enum CreditRole {
  president('president', 'President / GM', committee: true),
  vpFinance('vp_finance', 'VP Finance', committee: true),
  casinoManager('casino_manager', 'Casino Manager', committee: true),
  creditManager('credit_manager', 'Credit Manager', committee: true),
  shiftManager('shift_manager', 'Shift Manager'),
  host('host', 'Host'),
  cageDirector('cage_director', 'Director of Casino Cage', executive: false);

  final String wire;
  final String label;
  final bool committee;
  final bool executive;
  const CreditRole(this.wire, this.label, {this.committee = false, this.executive = true});

  static CreditRole? fromWire(String? w) {
    for (final r in values) {
      if (r.wire == w) return r;
    }
    return null;
  }
}

enum LineType { permanent, temporary }

/// Outcome of checking signatures against the authorizing policy.
class SignatureCheck {
  final bool satisfied;
  final String rule;
  final String? missing;
  const SignatureCheck(this.satisfied, this.rule, [this.missing]);
}

class Credit {
  static const refAuthorization = BookRef(6, '91', 'Credit authorization process (Fig 6.4)');
  static const refPolicy = BookRef(6, '103', 'Credit authorizing policy (Table 6.2)');
  static const refBank = BookRef(6, '92–93', 'Average balance rating codes');
  static const refLimits = BookRef(6, '101–102', 'Temporary increases and TTO');

  /// Decodes a bank rating such as "Low 5" → [10,000, 39,999] (pp.92–93).
  static (int, int) bankRatingRange(String level, int digits) {
    final l = level.toLowerCase();
    final base = l.startsWith('l') ? 1 : (l.startsWith('m') ? 4 : 7);
    final next = l.startsWith('l') ? 4 : (l.startsWith('m') ? 7 : 10);
    var unit = 1;
    for (var i = 1; i < digits; i++) {
      unit *= 10;
    }
    return (base * unit, next * unit - 1);
  }

  /// Max total line with a temporary increase of [pct] (book: 20–25%) (p.102).
  static double maxWithTemporaryIncrease(double established, {double pct = 0.25}) =>
      established * (1 + pct);

  /// Signature rules from Table 6.2. Each signer counts once.
  static SignatureCheck checkSignatures(LineType type, double amount, List<CreditRole> signers) {
    final s = signers.toSet();
    final execs = s.where((r) => r.executive).toSet();
    final committee = s.where((r) => r.committee).toSet();
    final cmOrVpf = s.contains(CreditRole.creditManager) || s.contains(CreditRole.vpFinance);
    if (type == LineType.permanent) {
      if (amount <= 50000) {
        const rule = '2 signatures: Credit Manager or VP Finance + 1 other credit executive';
        if (!cmOrVpf) return const SignatureCheck(false, rule, 'Credit Manager or VP Finance');
        if (execs.length < 2) return const SignatureCheck(false, rule, 'one more credit executive');
        return const SignatureCheck(true, rule);
      }
      if (amount <= 100000) {
        const rule = '3 signatures: Credit Manager or VP Finance + 1 credit executive + 1 credit committee member';
        if (!cmOrVpf) return const SignatureCheck(false, rule, 'Credit Manager or VP Finance');
        if (committee.length < 2) return const SignatureCheck(false, rule, 'a second credit committee member');
        if (execs.length < 3) return const SignatureCheck(false, rule, 'one more credit executive');
        return const SignatureCheck(true, rule);
      }
      const rule = 'Quorum: unanimous agreement of the full Credit Committee';
      final missing = CreditRole.values.where((r) => r.committee && !s.contains(r)).map((r) => r.label);
      return missing.isEmpty
          ? const SignatureCheck(true, rule)
          : SignatureCheck(false, rule, missing.join(', '));
    }
    if (amount <= 10000) {
      const rule = '1 signature: any credit executive';
      return execs.isEmpty ? const SignatureCheck(false, rule, 'a credit executive') : const SignatureCheck(true, rule);
    }
    if (amount <= 25000) {
      const rule = '2 signatures: any two credit executives';
      return execs.length < 2
          ? SignatureCheck(false, rule, '${2 - execs.length} more credit executive(s)')
          : const SignatureCheck(true, rule);
    }
    if (amount <= 50000) {
      const rule = '3 signatures: Credit Manager + any two credit executives';
      if (!s.contains(CreditRole.creditManager)) return const SignatureCheck(false, rule, 'Credit Manager');
      if (execs.length < 3) return SignatureCheck(false, rule, '${3 - execs.length} more credit executive(s)');
      return const SignatureCheck(true, rule);
    }
    return const SignatureCheck(false,
        'Temporary lines above \$50,000 are not covered by Table 6.2 — approve as a permanent line', 'permanent-line approval');
  }

  /// Write-offs need ≥2 of: President/GM, VP Finance, Credit Manager, Director of Cage (p.105).
  static bool writeOffApproved(List<CreditRole> signers) {
    const allowed = {CreditRole.president, CreditRole.vpFinance, CreditRole.creditManager, CreditRole.cageDirector};
    return signers.toSet().where(allowed.contains).length >= 2;
  }
}

/// Answers gathered while walking the Fig 6.4 authorization process.
class CreditCheckAnswers {
  final bool applicationComplete;
  final bool applicationLegible;
  final double amountRequested;
  final bool idCopied;
  final bool gamingReportObtained;
  final bool fourIn14;
  final bool consumerReportObtained;
  final bool consumerReportClear;
  final bool creditElsewhere;
  final bool inTransitRequested;
  final bool customerOwes;
  final bool afterBankingHours;
  final bool bankCheckObtained;
  final bool canSignAlone;
  final bool accountOpen6Months;
  final bool averageBalanceSupports;
  final bool hasDerogs;
  final bool derogsPaid;
  final bool bankInfoAtCentral;
  final bool currentLimitEqualsRequest;

  const CreditCheckAnswers({
    required this.applicationComplete,
    required this.applicationLegible,
    required this.amountRequested,
    required this.idCopied,
    required this.gamingReportObtained,
    required this.fourIn14,
    required this.consumerReportObtained,
    required this.consumerReportClear,
    required this.creditElsewhere,
    this.inTransitRequested = false,
    this.customerOwes = false,
    this.afterBankingHours = false,
    this.bankCheckObtained = false,
    this.canSignAlone = false,
    this.accountOpen6Months = false,
    this.averageBalanceSupports = false,
    this.hasDerogs = false,
    this.derogsPaid = false,
    this.bankInfoAtCentral = false,
    this.currentLimitEqualsRequest = false,
  });
}

enum CreditOutcome { readyForDecision, proceedWithCaution, referToCreditManager, doNotIssue, incomplete }

class CreditStep {
  final int number;
  final String question;
  final String answer;
  final String? note;
  const CreditStep(this.number, this.question, this.answer, [this.note]);
}

class CreditAssessment {
  final CreditOutcome outcome;
  final List<CreditStep> path;
  final List<String> referrals;
  const CreditAssessment(this.outcome, this.path, this.referrals);
}

/// Walks Fig 6.4 (p.91). Book flow; where the figure gives no "No" branch the
/// conservative reading (refer to credit manager) is used and marked as interpretation.
class CreditAuthorizationFlow {
  static CreditAssessment evaluate(CreditCheckAnswers a) {
    final path = <CreditStep>[];
    final referrals = <String>[];
    var caution = false;
    String yn(bool b) => b ? 'Yes' : 'No';

    path.add(CreditStep(1, 'Is credit application complete?', yn(a.applicationComplete),
        'Not complete until the customer signs'));
    if (!a.applicationComplete) return CreditAssessment(CreditOutcome.incomplete, path, ['Application must be completed and signed']);
    path.add(CreditStep(2, 'Is credit application legible?', yn(a.applicationLegible)));
    if (!a.applicationLegible) return CreditAssessment(CreditOutcome.incomplete, path, ['Application must be legible']);
    path.add(CreditStep(3, 'How much credit is requested?', '\$${a.amountRequested.toStringAsFixed(0)}'));
    path.add(CreditStep(4, 'Has identification/passport been photocopied?', yn(a.idCopied),
        'If customer not present, copy ID before issuing credit'));
    if (!a.idCopied) return CreditAssessment(CreditOutcome.incomplete, path, ['Photocopy identification first']);
    path.add(CreditStep(5, 'Has gaming report been obtained from Central?', yn(a.gamingReportObtained)));
    if (!a.gamingReportObtained) return CreditAssessment(CreditOutcome.incomplete, path, ['Obtain Central Credit gaming report']);
    path.add(CreditStep(6, 'Is customer reported as 4 in 14?', yn(a.fourIn14),
        '80% of 4-in-14 applicants write bad checks within 6 months (p.94)'));
    if (a.fourIn14) referrals.add('4 in 14 reported — see credit manager');
    path.add(CreditStep(7, 'Has consumer credit report been obtained?', yn(a.consumerReportObtained)));
    if (a.consumerReportObtained) {
      path.add(CreditStep(8, 'Is consumer credit report clear?', yn(a.consumerReportClear)));
      if (!a.consumerReportClear) referrals.add('Consumer credit report not clear — see credit manager');
    }
    path.add(CreditStep(9, 'Does customer have credit elsewhere?', yn(a.creditElsewhere)));

    void bankChecks(int first) {
      path.add(CreditStep(first, 'Has bank check been obtained?', yn(a.bankCheckObtained)));
      if (!a.bankCheckObtained) referrals.add('Bank check not obtained');
      path.add(CreditStep(first + 1, 'Can customer sign alone?', yn(a.canSignAlone),
          'A marker needing two signatures is of no use to the casino (p.93)'));
      if (!a.canSignAlone) referrals.add('Account needs a second signer — marker unusable');
      path.add(CreditStep(first + 2, 'Has account been open at least 6 months?', yn(a.accountOpen6Months)));
      if (!a.accountOpen6Months) referrals.add('Account open < 6 months — see credit manager');
      path.add(CreditStep(first + 3, 'Does average balance support the request?', yn(a.averageBalanceSupports)));
      if (!a.averageBalanceSupports) referrals.add('Average balance does not support request — see credit manager');
    }

    if (a.creditElsewhere) {
      path.add(const CreditStep(10, 'How long established with Central?', 'Recorded'));
      path.add(CreditStep(11, 'Has in-transit been requested?', yn(a.inTransitRequested)));
      if (!a.inTransitRequested) referrals.add('Request an in-transit report');
      path.add(CreditStep(12, 'Does customer owe?', yn(a.customerOwes)));
      if (a.customerOwes) referrals.add('Customer owes other casinos — see credit manager');
      path.add(CreditStep(13, 'Is it after banking hours?', yn(a.afterBankingHours)));
      if (!a.afterBankingHours) {
        bankChecks(14);
        path.add(CreditStep(18, 'Does customer have any derogs at Central?', yn(a.hasDerogs)));
        if (a.hasDerogs) {
          path.add(CreditStep(19, 'Are the derogs paid or owed?', a.derogsPaid ? 'Paid' : 'Owed'));
          if (!a.derogsPaid) {
            return CreditAssessment(CreditOutcome.doNotIssue, path, [...referrals, 'Derogatory balance owed — do not issue credit']);
          }
          path.add(const CreditStep(20, 'How recent? How much?', 'Review with credit manager'));
          referrals.add('Paid derogs — credit manager to judge recency and amount');
        }
      }
      path.add(CreditStep(21, 'Is any bank info available through Central?', yn(a.bankInfoAtCentral)));
      if (!a.bankInfoAtCentral) {
        caution = true;
      } else {
        path.add(CreditStep(22, "Does customer's current limit equal request?", yn(a.currentLimitEqualsRequest)));
        if (!a.currentLimitEqualsRequest) referrals.add('Request exceeds limits elsewhere — see credit manager');
      }
    } else {
      bankChecks(23);
    }
    path.add(const CreditStep(27, 'It is time to make a decision.', '—'));
    if (referrals.isNotEmpty) return CreditAssessment(CreditOutcome.referToCreditManager, path, referrals);
    if (caution) return CreditAssessment(CreditOutcome.proceedWithCaution, path, ['No bank info through Central — proceed with caution']);
    return CreditAssessment(CreditOutcome.readyForDecision, path, const []);
  }
}
