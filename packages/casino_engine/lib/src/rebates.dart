import 'dart:math' as math;
import 'book_ref.dart';
import 'stats.dart';
import 'game_math.dart';

enum BaccaratSide { banker, player }

class Rebates {
  static const ref = BookRef(15, '283–294', 'Rebates on loss');
  static const refPremium = BookRef(16, '304–310', 'Hidden cost of discounting');

  /// Exact effective house advantage after a rebate of [rebate] on net losses,
  /// for [hands] flat baccarat bets on [side]. Reproduces Tables 15.1, 15.3 and 16.1.
  static final _cache = <String, ({double e, double ePos})>{};

  /// E[casino result] and E[max(result, 0)] in units for [hands] flat bets (memoized).
  static ({double e, double ePos}) outcomeMoments(int hands, BaccaratSide side) {
    final key = '$hands|${side.name}';
    final hit = _cache[key];
    if (hit != null) return hit;
    final pt = GameMath.pTie;
    // Casino +1 when the bettor's side loses; casino −payout when it wins.
    final pUp = side == BaccaratSide.banker ? GameMath.pPlayer : GameMath.pBank;
    final pDn = side == BaccaratSide.banker ? GameMath.pBank : GameMath.pPlayer;
    final dnVal = side == BaccaratSide.banker ? -0.95 : -1.0;
    final lu = math.log(pUp), ld = math.log(pDn), lt = math.log(pt);
    final lgN = Stats.lgamma(hands + 1.0);
    final lgs = List<double>.generate(hands + 1, (k) => Stats.lgamma(k + 1.0));
    var e = 0.0, ePos = 0.0;
    for (var a = 0; a <= hands; a++) {
      for (var b = 0; a + b <= hands; b++) {
        final t = hands - a - b;
        final lp = lgN - lgs[a] - lgs[b] - lgs[t] + a * lu + b * ld + t * lt;
        if (lp < -700) continue;
        final p = math.exp(lp);
        final x = a + b * dnVal;
        e += p * x;
        if (x > 0) ePos += p * x;
      }
    }
    final r = (e: e, ePos: ePos);
    if (_cache.length > 200) _cache.clear();
    _cache[key] = r;
    return r;
  }

  /// Exact effective house advantage after a rebate of [rebate] on net losses,
  /// for [hands] flat baccarat bets on [side]. Reproduces Tables 15.1, 15.3 and 16.1.
  static double effectiveAdvantageBaccarat({required int hands, required double rebate, BaccaratSide side = BaccaratSide.banker}) {
    final m = outcomeMoments(hands, side);
    return (m.e - rebate * m.ePos) / hands;
  }

  /// Bet without rebate that earns the same as [bet] with the rebate (Tables 15.2, 15.4).
  static double equivalentBet(double bet, double effectiveAdvantage, double baseAdvantage) => bet * effectiveAdvantage / baseAdvantage;

  /// Normal-approximation cost of a rebate as share of theo (continuous version of pp.284–288).
  static double costShareNormal({required double expectedWin, required double sd, required double rebate}) {
    if (sd == 0) return rebate * (expectedWin > 0 ? 1 : 0);
    final z = expectedWin / sd;
    final ePos = expectedWin * Stats.normalCdf(z) + sd * Stats.normalPdf(z);
    return rebate * ePos / expectedWin;
  }

  static double _k(int n, double y) {
    final yn = y * n, sq = math.sqrt(n.toDouble());
    return yn * sq / (0.5 * yn * sq + 0.171 * yn * yn + 0.408 * n);
  }

  /// MacDonald: rebate % of actual loss that returns share [a] of theo (p.288).
  static double macdonaldRebatePct(double a, int nonTieHands, double y) => a * _k(nonTieHands, y);

  /// MacDonald inverse: share of theo returned by a rebate [b] (p.289).
  static double macdonaldCost(double b, int nonTieHands, double y) => b / _k(nonTieHands, y);

  /// Variable betting: effective N = total wagered / largest bet (p.288).
  static double effectiveHands(double totalWagered, double largestBet) => totalWagered / largestBet;

  /// Graduated schedule: the largest rebate whose effective advantage stays ≥ [floor] at each hands level (p.291).
  static Map<int, double> graduatedSchedule({
    required List<int> handLevels,
    required List<double> rebateSteps,
    required double floor,
    BaccaratSide side = BaccaratSide.banker,
  }) {
    final out = <int, double>{};
    for (final n in handLevels) {
      var best = 0.0;
      for (final r in rebateSteps) {
        if (effectiveAdvantageBaccarat(hands: n, rebate: r, side: side) >= floor) best = math.max(best, r);
      }
      out[n] = best;
    }
    return out;
  }
}

/// Premium deal evaluator (Ch16, Table 16.2 p.307).
class PremiumDeal {
  final double creditLine, betPctOfLine, hours, handsPerHour;
  final double baseAdvantage, discountOnLoss;
  final double compPctOfTheo, compVariableCostPct;
  final double airfare, walkInMoney, otherCosts, gamingTax;
  final BaccaratSide side;
  const PremiumDeal({
    this.creditLine = 150000,
    this.betPctOfLine = 0.02,
    this.hours = 9,
    this.handsPerHour = 60,
    this.baseAdvantage = 0.0106,
    this.discountOnLoss = 0.10,
    this.compPctOfTheo = 0.45,
    this.compVariableCostPct = 0.45,
    this.airfare = 9000,
    this.walkInMoney = 0,
    this.otherCosts = 0,
    this.gamingTax = 0.0625,
    this.side = BaccaratSide.banker,
  });

  int get hands => (hours * handsPerHour).round();
  double get bet => creditLine * betPctOfLine;
  double get wagered => bet * hands;
}

class PremiumDealResult {
  final double effectiveAdvantage, theo, rfbCost, tax, contribution, probabilityCasinoLoses;
  const PremiumDealResult(this.effectiveAdvantage, this.theo, this.rfbCost, this.tax, this.contribution, this.probabilityCasinoLoses);
}

class PremiumDeals {
  static const ref = BookRef(16, '305–310', 'Net effect of a premium play');

  static PremiumDealResult evaluate(PremiumDeal d, {double? effectiveAdvantageOverride}) {
    final n = d.hands;
    final eff = effectiveAdvantageOverride ??
        (n <= 2000
            ? Rebates.effectiveAdvantageBaccarat(hands: n, rebate: d.discountOnLoss, side: d.side)
            : d.baseAdvantage * (1 - d.discountOnLoss));
    final theo = d.wagered * eff;
    final rfb = d.wagered * d.baseAdvantage * d.compPctOfTheo * d.compVariableCostPct;
    final tax = theo * d.gamingTax;
    final contribution = theo - rfb - d.airfare - d.walkInMoney - d.otherCosts - tax;
    final sd = Stats.sessionSd([(bet: d.bet, hands: n)], d.side == BaccaratSide.banker ? 0.9274 : 0.9512);
    final pLoss = Stats.normalCdf((0 - d.wagered * d.baseAdvantage) / sd);
    return PremiumDealResult(eff, theo, rfb, tax, contribution, pLoss);
  }
}
