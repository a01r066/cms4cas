import 'book_ref.dart';

class Promotions {
  static const refMatch = BookRef(14, '255–260', 'Cost of match plays and nonnegotiables');
  static const refSpree = BookRef(14, '260–267', "Gambler's spree evaluation");
  static const refDeadChip = BookRef(14, '267–276', 'Dead chips and chip warrants');

  /// Cost of a match play coupon (with/without exchange) net of the casino's edge on the cash match (pp.256, 259).
  static ({double couponCost, double cashGain, double netCost}) matchPlayCost({
    required double face,
    required double cashMatch,
    required double houseAdvantage,
    bool withExchange = true,
    double tax = 0,
  }) {
    final pWin = 0.5 - houseAdvantage / 2, pLoss = 0.5 + houseAdvantage / 2;
    if (withExchange) {
      final coupon = pWin * face;
      final cash = cashMatch * houseAdvantage * (1 - tax);
      return (couponCost: coupon, cashGain: cash, netCost: coupon - cash);
    }
    final times = 1 / pLoss;
    final coupon = face - face * times * houseAdvantage;
    final cash = cashMatch * times * houseAdvantage * (1 - tax);
    return (couponCost: coupon, cashGain: cash, netCost: coupon - cash);
  }

  /// Nonnegotiable chip (no cash match) (p.256).
  static double nonnegotiableCost({required double face, required double houseAdvantage, bool withExchange = true}) =>
      matchPlayCost(face: face, cashMatch: 0, houseAdvantage: houseAdvantage, withExchange: withExchange).couponCost;

  /// Wagers needed for the casino to recover a cost after tax (p.260).
  static double wagersToRecover(double cost, double houseAdvantage, {double tax = 0.0625}) =>
      cost / (houseAdvantage * (1 - tax));

  /// Gambler's spree style program P&L (Table 14.1 logic, p.262). All positive = casino gain.
  static ({double beforeTax, double tax, double beforeLabor, double labor, double net}) programPnL({
    required double hours,
    required double avgBet,
    required double betsWonPerHour,
    required double incentivesCost,
    required double cashAwards,
    required double mealDiscounts,
    required double roomDiscountLoss,
    required double laborPerHour,
    double tax = 0.0625,
  }) {
    final win = hours * avgBet * betsWonPerHour;
    final before = win - incentivesCost - cashAwards - mealDiscounts - roomDiscountLoss;
    final t = win * tax;
    final beforeLabor = before - t;
    final labor = hours * laborPerHour;
    return (beforeTax: before, tax: t, beforeLabor: beforeLabor, labor: labor, net: beforeLabor - labor);
  }

  /// Dead chips: wagers until lost = chips / P(other side wins); casino theo = wagers × HA (p.268).
  static ({double wagers, double theo, double hours}) deadChipWash({
    required double deadChips,
    required double pOtherSideWins,
    required double houseAdvantage,
    required double betSize,
    required double handsPerHour,
  }) {
    final w = deadChips / pOtherSideWins;
    return (wagers: w, theo: w * houseAdvantage, hours: w / betSize / handsPerHour);
  }

  /// One buy-in round: casino result incl. bonus, before & after tax (pp.268–270).
  static ({double casinoWin, double tax, double net}) deadChipRound({
    required double cash,
    required double bonusPct,
    required double pOtherSideWins,
    required double houseAdvantage,
    double gamingTax = 0.0625,
  }) {
    final chips = cash * (1 + bonusPct);
    final theo = chips / pOtherSideWins * houseAdvantage;
    final casino = theo - (chips - cash);
    final t = theo * gamingTax;
    return (casinoWin: casino, tax: t, net: casino - t);
  }

  /// Bonus that cuts the house theoretical by [reduction] (e.g. 0.5) for a side (pp.271–272).
  static double deadChipBonusForReduction({required double reduction, required double pOtherSideWins, required double houseAdvantage}) {
    final theoPerChip = houseAdvantage / pOtherSideWins;
    final price = 1 - reduction * theoPerChip;
    return 1 / price - 1;
  }

  /// Effective house advantage after a dead-chip bonus (p.273).
  static double deadChipEffectiveAdvantage({required double bonusPct, required double pOtherSideWins, required double houseAdvantage}) {
    final price = 1 / (1 + bonusPct);
    final wagers = 1 / pOtherSideWins;
    return (wagers * houseAdvantage - (1 - price)) / wagers;
  }
}
