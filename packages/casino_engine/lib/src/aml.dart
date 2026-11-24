import 'book_ref.dart';

enum CashDirection { cashIn, cashOut }

/// Transaction types from Reg 6A.030 examples (p.68). Wire values are stable.
enum CashTxType {
  losingCashWager('losing_cash_wager', 'Losing cash wager (table)', CashDirection.cashIn),
  cashWagerOther('cash_wager_other', 'Cash wager — keno / race & sports', CashDirection.cashIn),
  chipPurchase('chip_purchase', 'Chip / token purchase', CashDirection.cashIn),
  markerPayment('marker_payment', 'Marker payment', CashDirection.cashIn),
  frontMoneyDeposit('front_money_deposit', 'Front money deposit', CashDirection.cashIn),
  chipRedemption('chip_redemption', 'Chip redemption', CashDirection.cashOut),
  winningTicket('winning_ticket', 'Winning ticket payout (keno, R&S, bingo)', CashDirection.cashOut),
  frontMoneyWithdrawal('front_money_withdrawal', 'Front money withdrawal', CashDirection.cashOut),
  checkCashing('check_cashing', 'Check cashed / credit-card cash advance', CashDirection.cashOut),
  slotClubCashout('slot_club_cashout', 'Slot club points cashed out', CashDirection.cashOut),
  wireTransferCash('wire_transfer_cash', 'Cash from wire transfer', CashDirection.cashOut),
  tournamentWinnings('tournament_winnings', 'Tournament winnings', CashDirection.cashOut),
  jackpotPayout('jackpot_payout', 'Slot jackpot paid in cash', CashDirection.cashOut),
  otherPayment('other_payment', 'Marketing incentive / travel reimbursement', CashDirection.cashOut);

  final String wire;
  final String label;
  final CashDirection direction;
  const CashTxType(this.wire, this.label, this.direction);

  static CashTxType fromWire(String w) =>
      values.firstWhere((t) => t.wire == w, orElse: () => CashTxType.chipPurchase);
}

enum AggregationRegime {
  /// Nevada Reg 6A (book, 2003): like-kind within area + single-visit rule.
  reg6a('reg6a', 'Nevada Regulation 6A (2003)'),

  /// Federal Title 31: all cash-in together, all cash-out together per gaming day.
  title31('title31', 'Title 31 (federal BSA)');

  final String wire;
  final String label;
  const AggregationRegime(this.wire, this.label);
  static AggregationRegime fromWire(String w) => values.firstWhere((r) => r.wire == w, orElse: () => title31);
}

/// Jurisdiction thresholds (book defaults = 2003 rules, p.63–78). Editable in settings.
class AmlProfile {
  final AggregationRegime regime;
  final double ctrThreshold; // report when total EXCEEDS this
  final double mtlThreshold; // log every transaction exceeding this
  final double cashForCashLimit; // null-like (0) disables
  final double casinoCheckForCashLimit;
  final double sarThreshold;
  final int sarFileDays;
  final int sarExtensionDays;
  final int gamingDayStartHour; // casino-chosen 24h cutoff
  final double nearThresholdPct; // alert when within this share of the CTR threshold

  const AmlProfile({
    this.regime = AggregationRegime.reg6a,
    this.ctrThreshold = 10000,
    this.mtlThreshold = 3000,
    this.cashForCashLimit = 3000,
    this.casinoCheckForCashLimit = 3000,
    this.sarThreshold = 5000,
    this.sarFileDays = 30,
    this.sarExtensionDays = 30,
    this.gamingDayStartHour = 6,
    this.nearThresholdPct = 0.8,
  });

  static const bookNevada2003 = AmlProfile();
}

class CashTx {
  final String id;
  final String patronKey; // player id, or a description for unknown patrons
  final CashTxType type;
  final double amount;
  final String area; // pit/table, cage, keno...
  final DateTime at;
  final String? visitId; // continuous appearance at one location (single-visit rule)
  const CashTx({
    required this.id,
    required this.patronKey,
    required this.type,
    required this.amount,
    required this.area,
    required this.at,
    this.visitId,
  });
}

enum AggBasis { likeKind, singleVisit, directionTotal }

class Aggregate {
  final String patronKey;
  final DateTime gamingDay;
  final CashDirection direction;
  final AggBasis basis;
  final String label;
  final double total;
  final List<String> txIds;
  final bool reportable;
  final bool nearThreshold;
  const Aggregate({
    required this.patronKey,
    required this.gamingDay,
    required this.direction,
    required this.basis,
    required this.label,
    required this.total,
    required this.txIds,
    required this.reportable,
    required this.nearThreshold,
  });
  bool get multiple => txIds.length > 1;
}

class Aml {
  static const ref = BookRef(5, '61–82', 'Currency reporting (Reg 6A / Title 31)');

  /// The gaming day a timestamp belongs to, given the casino's cutoff hour (p.72).
  static DateTime gamingDay(DateTime t, int startHour) {
    final shifted = t.subtract(Duration(hours: startHour));
    return DateTime(shifted.year, shifted.month, shifted.day);
  }

  /// Does this transaction need a Multiple Transaction Log entry? (p.63, 69)
  /// Also true when sub-threshold same-type amounts for the patron combine above the MTL threshold.
  static bool needsMtlEntry(CashTx tx, List<CashTx> sameDayEarlier, AmlProfile p) {
    if (tx.amount > p.mtlThreshold) return true;
    final combined = sameDayEarlier
        .where((e) => e.patronKey == tx.patronKey && e.type == tx.type)
        .fold<double>(tx.amount, (a, e) => a + e.amount);
    return combined > p.mtlThreshold;
  }

  /// Aggregates per patron per gaming day under the profile's regime.
  /// Cash-in is never combined with cash-out (p.69).
  static List<Aggregate> aggregate(List<CashTx> txs, AmlProfile p) {
    final out = <Aggregate>[];
    final byKey = <String, List<CashTx>>{};
    for (final t in txs) {
      final day = gamingDay(t.at, p.gamingDayStartHour);
      byKey.putIfAbsent('${t.patronKey}|${day.toIso8601String()}', () => []).add(t);
    }
    Aggregate make(List<CashTx> g, AggBasis basis, String label) {
      final total = g.fold<double>(0, (a, t) => a + t.amount);
      return Aggregate(
        patronKey: g.first.patronKey,
        gamingDay: gamingDay(g.first.at, p.gamingDayStartHour),
        direction: g.first.type.direction,
        basis: basis,
        label: label,
        total: total,
        txIds: g.map((t) => t.id).toList(),
        reportable: total > p.ctrThreshold,
        nearThreshold: total <= p.ctrThreshold && total >= p.ctrThreshold * p.nearThresholdPct,
      );
    }

    for (final group in byKey.values) {
      for (final dir in CashDirection.values) {
        final d = group.where((t) => t.type.direction == dir).toList();
        if (d.isEmpty) continue;
        if (p.regime == AggregationRegime.title31) {
          out.add(make(d, AggBasis.directionTotal, dir == CashDirection.cashIn ? 'All cash-in' : 'All cash-out'));
          continue;
        }
        final byType = <CashTxType, List<CashTx>>{};
        for (final t in d) {
          byType.putIfAbsent(t.type, () => []).add(t);
        }
        for (final e in byType.entries) {
          out.add(make(e.value, AggBasis.likeKind, e.key.label));
        }
        final byVisit = <String, List<CashTx>>{};
        for (final t in d.where((t) => t.visitId != null)) {
          byVisit.putIfAbsent(t.visitId!, () => []).add(t);
        }
        for (final e in byVisit.entries) {
          if (e.value.map((t) => t.type).toSet().length > 1) {
            out.add(make(e.value, AggBasis.singleVisit, 'Single visit at ${e.value.first.area}'));
          }
        }
      }
    }
    out.sort((a, b) => b.total.compareTo(a.total));
    return out;
  }

  /// Reg 6A prohibited transactions (p.63). Returns a reason or null.
  static String? prohibited({
    required AmlProfile profile,
    required String kind, // 'cash_for_cash' | 'casino_check_for_cash' | 'winnings_to_third_party'
    required double amount,
    bool verifiedWinnings = false,
  }) {
    if (profile.regime != AggregationRegime.reg6a) return null;
    switch (kind) {
      case 'cash_for_cash':
        return amount > profile.cashForCashLimit
            ? 'Cash-for-cash exchange over \$${profile.cashForCashLimit.toStringAsFixed(0)} is prohibited (incl. foreign currency)'
            : null;
      case 'casino_check_for_cash':
        return amount > profile.casinoCheckForCashLimit && !verifiedWinnings
            ? 'Casino check for cash over \$${profile.casinoCheckForCashLimit.toStringAsFixed(0)} is prohibited unless for verified winnings'
            : null;
      case 'winnings_to_third_party':
        return 'Checks or wires for winnings must be in the winning patron\'s name';
    }
    return null;
  }

  /// SAR due date: detection + 30 days, extendable 30 more to identify a suspect (p.78).
  static DateTime sarDueDate(DateTime detected, AmlProfile p, {bool extended = false}) =>
      detected.add(Duration(days: p.sarFileDays + (extended ? p.sarExtensionDays : 0)));

  /// Fields required on a CTRC-N (p.63–68).
  static const ctrRequiredFields = [
    'Date and time of transaction',
    'Amount',
    'Transaction type',
    "Patron's name",
    "Patron's permanent address",
    'ID method, document type and number',
    'Social Security number (or national ID)',
    'Date of birth and casino account number',
    'Signature of employee recording the transaction',
    'Signature of a different employee who reviewed it',
  ];
}
