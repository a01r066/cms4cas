import 'book_ref.dart';

class CompPolicy {
  final double pctOfTheo; // book: 35–50% (p.310); 45% example (p.303)
  final double quickLossPctOfActual; // 15% of actual loss (p.303)
  final bool quickLossEnabled;
  const CompPolicy({this.pctOfTheo = 0.45, this.quickLossPctOfActual = 0.15, this.quickLossEnabled = true});
}

class Comps {
  static const ref = BookRef(16, '303, 308–310', 'RFB comps and quick-loss policy');
  static const refCriteria = BookRef(15, '294–298', 'Player action criteria (Tables 15.5–15.6)');

  /// Comp allowance = max(pct × theo, quick-loss pct × actual loss) (p.303).
  static ({double allowance, String basis}) allowance({required double theo, required double actualLoss, CompPolicy policy = const CompPolicy()}) {
    final byTheo = theo * policy.pctOfTheo;
    final byLoss = policy.quickLossEnabled && actualLoss > 0 ? actualLoss * policy.quickLossPctOfActual : 0.0;
    return byLoss > byTheo
        ? (allowance: byLoss, basis: 'Quick loss: ${(policy.quickLossPctOfActual * 100).toStringAsFixed(0)}% of actual loss')
        : (allowance: byTheo, basis: '${(policy.pctOfTheo * 100).toStringAsFixed(0)}% of theoretical win');
  }

  /// When a discount on loss is in place, comps must use the post-discount advantage (p.310).
  static double theoAfterDiscount(double theoAtBookAdvantage, double baseAdvantage, double effectiveAdvantage) =>
      baseAdvantage == 0 ? 0 : theoAtBookAdvantage * effectiveAdvantage / baseAdvantage;
}

class ActionCriteriaAssumptions {
  final double betPctOfCredit; // 2.0%
  final Map<String, double> betsWonPerHour; // BJ/bac 1.00, dice 0.38, roulette 3.41
  final double hoursPerNight; // 4
  final int nights; // 3
  final double markersPctOfLine; // 60%
  final double badDebtPctOfMarkers; // 3.5%
  final double gamingTax; // 6.25%
  const ActionCriteriaAssumptions({
    this.betPctOfCredit = 0.02,
    this.betsWonPerHour = const {'Blackjack & Baccarat': 1.00, 'Dice': 0.38, 'Roulette': 3.41},
    this.hoursPerNight = 4,
    this.nights = 3,
    this.markersPctOfLine = 0.60,
    this.badDebtPctOfMarkers = 0.035,
    this.gamingTax = 0.0625,
  });
}

class ActionCriteriaRow {
  final double creditLine, theo, badDebt, taxes, availableForComps;
  final Map<String, double> requiredBet;
  const ActionCriteriaRow(this.creditLine, this.theo, this.badDebt, this.taxes, this.availableForComps, this.requiredBet);
}

class ActionCriteria {
  /// Builds a Table 15.6-style row: same theo target for every game; bet requirement per game.
  static ActionCriteriaRow row(double creditLine, [ActionCriteriaAssumptions a = const ActionCriteriaAssumptions()]) {
    final baseBet = creditLine * a.betPctOfCredit;
    final hours = a.hoursPerNight * a.nights;
    final baseRate = a.betsWonPerHour.values.first;
    final theo = baseBet * baseRate * hours;
    final badDebt = creditLine * a.markersPctOfLine * a.badDebtPctOfMarkers;
    final taxes = (theo - badDebt) * a.gamingTax;
    return ActionCriteriaRow(
      creditLine, theo, badDebt, taxes, theo - badDebt - taxes,
      {for (final e in a.betsWonPerHour.entries) e.key: theo / (e.value * hours)},
    );
  }

  /// Equivalent play: bet × hours is constant ($100 × 4h = $50 × 8h) (Table 15.5 note).
  static double requiredBetForHours(double betAtBaseHours, double baseHours, double hours) => betAtBaseHours * baseHours / hours;
}
