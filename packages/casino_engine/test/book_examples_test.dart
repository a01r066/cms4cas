// Golden tests: every expectation is a printed result from the book (page cited).
import 'package:casino_engine/casino_engine.dart';
import 'package:test/test.dart';

Matcher near(num v, [num tol = 0.005]) => closeTo(v, tol);

void main() {
  group('Ch3 taxes', () {
    test('NV tiers on \$200,000 (p.36)', () {
      expect(GamingTax.tieredTax(200000, GamingTax.nevada2003), near(1750 + 3780 + 66000 * 0.0675));
    });
    test('AC adjusted win uses the smaller of 4% or provision (p.39)', () {
      expect(GamingTax.atlanticCity(grossWin: 1000000, badDebtProvision: 60000), near(76800));
      expect(GamingTax.atlanticCity(grossWin: 1000000, badDebtProvision: 10000), near(79200));
    });
  });

  group('Ch4 staffing', () {
    test('Monday BJ 40/40/20 stations → 133.3 dealers (p.55)', () {
      expect(Staffing.perShift(40) * 2 + Staffing.perShift(20), near(133.33, 0.01));
    });
    test('BJ 1066.5 weekly shifts → 213.30 → 221.83 (p.56)', () {
      expect(1066.5 / 5, near(213.30));
      expect(Staffing.payroll(1066.5), near(221.83));
    });
    test('Floor: 10 stations ×480/380 → 13; 5 → 7 (p.57)', () {
      expect(Staffing.floorPerShift(40), 13);
      expect(Staffing.floorPerShift(20), 7);
    });
    test('Busiest day binds: 280 stations → 74.67 vs 80 (p.59)', () {
      final plan = Staffing.plan([[25], [25], [25], [25], [60], [60], [60]]);
      expect(plan.formulaHeads, near(74.67));
      expect(plan.busiestDayHeads, near(80));
      expect(plan.busiestDayBinds, isTrue);
    });
  });

  group('Ch6 credit', () {
    test('Bank codes Low 5 / High 4 (p.93)', () {
      expect(Credit.bankRatingRange('Low', 5), (10000, 39999));
      expect(Credit.bankRatingRange('High', 4), (7000, 9999));
    });
    test('Temporary increase \$10k → \$12.5k (p.102)', () {
      expect(Credit.maxWithTemporaryIncrease(10000), 12500);
    });
  });

  group('Ch7 slots', () {
    test('Joker-wild V.I. at 90% = 8.01219 (p.128)', () {
      final r = Slots.volatilityIndex([
        (net: 1, hits: 28111), (net: -1, hits: 2455), (net: -4, hits: 1536), (net: -9, hits: 559),
        (net: -49, hits: 99), (net: -199, hits: 7), (net: -399, hits: 1),
      ], 0.2392);
      expect(r.variance, near(23.5795, 0.001));
      expect(r.vi, near(8.0122, 0.001));
    });
    test('Par sheet 91.99% at 1,000 pulls → 53.40%–130.58% (p.123)', () {
      final r = Slots.paybackRange(91.99, 1220.3, 1000);
      expect(r.low, near(53.40, 0.01));
      expect(r.high, near(130.58, 0.01));
    });
    test('PRNG 6z mod 13 (p.139)', () {
      expect(Slots.lcg6z13(1, 12), [6, 10, 8, 9, 2, 12, 7, 3, 5, 4, 11, 1]);
    });
  });

  group('Ch9 table games', () {
    test('Marker vs name credit: same \$20,000 win (p.174)', () {
      final m = TableGames.compute(const TableShiftInput(openingInventory: 140000, fills: 50000, credits: 10000,
          closingInventory: 110000, currencyInBox: 60000, markersIssued: 100000, markersRedeemedInPitCheques: 70000));
      expect(m.drop, 90000);
      expect(m.win, 20000);
      expect(m.hold, near(0.2222, 0.0001));
      expect(m.statisticalDrop, 160000);
      expect(m.statisticalHold, near(0.125));
      final n = TableGames.compute(const TableShiftInput(openingInventory: 140000, fills: 50000, credits: 10000,
          closingInventory: 40000, currencyInBox: 60000, markersIssued: 100000, system: MarkerSystem.nameCredit));
      expect(n.drop, 160000);
      expect(n.win, 20000);
    });
    test('Martingale: 20 straight losses = 1 in 375,899.74 (p.186)', () {
      var p = 1.0;
      for (var i = 0; i < 20; i++) {
        p *= 20 / 38;
      }
      expect(1 / p, near(375899.74, 0.5));
    });
  });

  group('Ch11 game math', () {
    test('Pass line odds multiples (p.211)', () {
      expect(GameMath.passLineWithOdds(1) * 100, near(0.8485, 0.0001));
      expect(GameMath.passLineWithOdds(2) * 100, near(0.6061, 0.0001));
      expect(GameMath.passLineWithOdds(4) * 100, near(0.3857, 0.0001));
      expect(GameMath.passLineWithOdds(10) * 100, near(0.1845, 0.0001));
    });
    test('Roulette 5.26% (p.214)', () {
      expect(GameMath.rouletteEdge(waysToWin: 1, pays: 35) * 100, near(5.263, 0.001));
    });
    test('Baccarat edges with and without ties (pp.214–216)', () {
      expect(GameMath.baccaratBankEdge() * 100, near(1.0579, 0.0001));
      expect(GameMath.baccaratPlayerEdge() * 100, near(1.2351, 0.0001));
      expect(GameMath.baccaratBankEdge(includeTies: false) * 100, near(1.1692, 0.0005));
      expect(GameMath.baccaratPlayerEdge(includeTies: false) * 100, near(1.365, 0.0005));
      expect(GameMath.baccaratBankEdge(commission: 0.04) * 100, near(0.5993, 0.0001));
      expect(GameMath.baccaratBankEdge(commission: 0) * 100, near(-1.2351, 0.0001));
    });
    test('Baccarat tie bet 9 for 1 / 10 for 1 (p.300)', () {
      expect(GameMath.baccaratTieEdge(9) * 100, near(14.3596, 0.0005));
      expect(GameMath.baccaratTieEdge(10) * 100, near(4.844, 0.0005));
    });
    test('Keno 4-spot 27.13% (p.218)', () {
      expect(GameMath.kenoEdge(4, {4: 112, 3: 4, 2: 1}) * 100, near(27.13, 0.01));
    });
    test('BJ 6 decks + H17 = 0.76% (Table 11.5 note 3)', () {
      expect(GameMath.blackjackEdgePct(6, ['Dealer hits soft 17']), near(0.76));
    });
    test('BJ example rules in Ch12 → 0.26% (p.223)', () {
      expect(GameMath.blackjackEdgePct(6, ['Late surrender', 'Double after splitting', 'Resplit aces']), near(0.26));
    });
  });

  group('Ch12 rating', () {
    test('Roulette \$150 × 2.25h × 60 × 5.26% = \$1,065.15 (p.221)', () {
      expect(Rating.theo(averageBet: 150, hours: 2.25, decisionsPerHour: 60, houseAdvantage: 0.0526), near(1065.15));
    });
    test('Average BJ player \$150 × 4h × 80 × 2.5% × 0.60 = \$720 (p.223)', () {
      expect(Rating.theo(averageBet: 150, hours: 4, decisionsPerHour: 80, houseAdvantage: 0.025 * 0.60), near(720));
    });
    test('Decisions interpolate Table 13.1 (dice 4 players between 216 and 144)', () {
      expect(RatingDefaults.byId('craps').decisionsPerHour(4), near(180));
      expect(RatingDefaults.byId('blackjack').decisionsPerHour(7), 52);
    });
  });

  group('Ch13 hold', () {
    test('Hold objective 25% at 5.26% → 4.75× (p.249)', () {
      expect(TableGames.wagerMultipleForHold(0.25, 0.0526), near(4.75));
    });
    test('Utilization example: 1 player 20.9%, 7 players 5.2% (p.244)', () {
      expect(10 * 209 * 0.01 / 100, near(0.209));
      expect(10 * 7 * 52 * 0.01 / 700, near(0.052));
    });
  });

  group('Ch14 promotions', () {
    test('\$5 match play costs (p.257)', () {
      expect(Promotions.matchPlayCost(face: 5, cashMatch: 5, houseAdvantage: 0.015).netCost, near(2.3875, 0.0001));
      expect(Promotions.matchPlayCost(face: 5, cashMatch: 5, houseAdvantage: 0.015, withExchange: false).netCost, near(4.7044, 0.0001));
      expect(Promotions.nonnegotiableCost(face: 5, houseAdvantage: 0.015), near(2.4625, 0.0001));
      expect(Promotions.nonnegotiableCost(face: 5, houseAdvantage: 0.015, withExchange: false), near(4.8522, 0.0001));
    });
    test('After tax \$2.3922 → \$170.11 → 34.02 hands → 40.8 min (p.259–260)', () {
      final c = Promotions.matchPlayCost(face: 5, cashMatch: 5, houseAdvantage: 0.015, tax: 0.0625).netCost;
      expect(c, near(2.3922, 0.0001));
      final w = Promotions.wagersToRecover(c, 0.015);
      expect(w, near(170.11, 0.01));
      expect(w / 5, near(34.02, 0.01));
    });
    test("Gambler's spree minimum play loses \$229.24 (Table 14.1)", () {
      final r = Promotions.programPnL(hours: 8, avgBet: 5, betsWonPerHour: 1, incentivesCost: 24.625 + 73.875,
          cashAwards: 100, mealDiscounts: 30, roomDiscountLoss: 10, laborPerHour: 28.27 / 8);
      expect(r.beforeTax, near(-198.50, 0.01));
      expect(r.beforeLabor, near(-201.00, 0.01));
      // Book prints −229.24, but its own lines (−201.00 − 28.27) sum to −229.27 (errata).
      expect(r.net, near(-229.27, 0.01));
    });
    test('Dead chip first wash \$224,598 / \$2,785 / 3.7 h (p.268–269)', () {
      final w = Promotions.deadChipWash(deadChips: 103000, pOtherSideWins: 0.4585974, houseAdvantage: 0.0124, betSize: 1000, handsPerHour: 60);
      expect(w.wagers, near(224598, 1));
      expect(w.theo, near(2785, 1));
      expect(w.hours, near(3.74, 0.01));
    });
    test('Dead chip 1.2% bonus halves banker edge; effective HA table (p.271–273)', () {
      expect(Promotions.deadChipBonusForReduction(reduction: 0.5, pOtherSideWins: 0.4462466, houseAdvantage: 0.010579) * 100, near(1.2, 0.01));
      expect(Promotions.deadChipEffectiveAdvantage(bonusPct: 0.015, pOtherSideWins: 0.4462466, houseAdvantage: 0.010579) * 100, near(0.40, 0.005));
      expect(Promotions.deadChipEffectiveAdvantage(bonusPct: 0.015, pOtherSideWins: 0.4585974, houseAdvantage: 0.012351) * 100, near(0.56, 0.005));
      expect(Promotions.deadChipEffectiveAdvantage(bonusPct: 0.0075, pOtherSideWins: 0.4462466, houseAdvantage: 0.010579) * 100, near(0.73, 0.005));
    });
  });

  group('Ch15–16 rebates and premium play', () {
    test('Table 16.1 banker effective HA', () {
      double e(int n, double r) => Rebates.effectiveAdvantageBaccarat(hands: n, rebate: r) * 100;
      expect(e(50, 0.05), near(0.77));
      expect(e(50, 0.20), near(-0.10));
      expect(e(100, 0.10), near(0.63));
      expect(e(300, 0.20), near(0.52));
      expect(e(300, 0.25), near(0.38));
    });
    test('Table 15.3 player side 50 hands 5% = 0.93% (p.293)', () {
      expect(Rebates.effectiveAdvantageBaccarat(hands: 50, rebate: 0.05, side: BaccaratSide.player) * 100, near(0.93));
    });
    test('Equivalent bet \$488 at 300 hands / 20% (Table 15.2)', () {
      final eff = Rebates.effectiveAdvantageBaccarat(hands: 300, rebate: 0.20);
      expect(Rebates.equivalentBet(1000, eff, 0.0106), near(488, 6));
    });
    test('MacDonald 32.85% and 15.7% (pp.288–289)', () {
      expect(Rebates.macdonaldRebatePct(0.5, 1000, 0.0136) * 100, near(32.85, 0.01));
      expect(Rebates.macdonaldCost(0.10, 900, 0.0136) * 100, near(15.7, 0.05));
    });
    test('Session SD \$4,756 and uneven \$1,345.66 (pp.285, 368)', () {
      expect(Stats.sessionSd([(bet: 500, hands: 100)], 0.9512), near(4756, 0.5));
      expect(Stats.sessionSd([(bet: 120, hands: 40), (bet: 200, hands: 35), (bet: 50, hands: 10), (bet: 5, hands: 15)], 0.9512), near(1345.66, 0.01));
    });
    test('Normal approximation of a 10% rebate ≈ 35–38% of theo (p.286)', () {
      final s = Rebates.costShareNormal(expectedWin: 617.5, sd: 4756, rebate: 0.10);
      expect(s, inInclusiveRange(0.35, 0.385));
    });
    test('Premium trip contribution ≈ \$280 (Table 16.2)', () {
      final r = PremiumDeals.evaluate(const PremiumDeal(), effectiveAdvantageOverride: 0.0084);
      expect(r.theo, near(13608, 1));
      expect(r.rfbCost, near(3477, 1));
      expect(r.contribution, near(280, 1));
    });
    test('Player action criteria \$3,000 line (Table 15.6)', () {
      final r = ActionCriteria.row(3000);
      expect(r.theo, near(720));
      expect(r.badDebt, near(63));
      expect(r.taxes, near(41.06, 0.01));
      expect(r.availableForComps, near(615.94, 0.01));
      expect(r.requiredBet['Dice'], near(157.9, 0.1));
      expect(r.requiredBet['Roulette'], near(17.6, 0.1));
    });
  });

  group('Ch17–18 sports and race', () {
    test('7:5 → −145/+135; disadvantages (p.326–327)', () {
      final l = SportsBook.lineFromOdds(7, 5);
      expect(l.favorite, -145);
      expect(l.underdog, 135);
    });
    test('Ideal balance −150/+130 → 57.98% / 3.36% (p.330)', () {
      final b = SportsBook.idealBalance(150, 130);
      expect(b.share, near(0.579832, 0.000001));
      expect(b.bookAdvantage, near(0.033613, 0.000001));
      expect(SportsBook.breakEvenPct(160), near(0.615, 0.001));
    });
    test('3-team parlay 25%; line moves (p.331, 338)', () {
      expect(SportsBook.parlayEdge(3, 6), near(0.25));
      expect(SportsBook.lineMove(20), 10);
      expect(SportsBook.lineMove(60), 15);
    });
    test('Pari-mutuel \$4.20; house quinella \$777; trifecta \$13,799.52 (pp.344–354)', () {
      expect(RaceBook.payoutPer2(pool: 2000, onHorse: 800), near(4.20));
      expect(RaceBook.houseQuinella(74, 21), 777);
      expect(RaceBook.houseTrifecta(74, 21, 7.40), near(13799.52, 0.01));
    });
  });

  group('Ch19 statistics', () {
    const holds = [15.4, 16.4, 16.4, 16.8, 16.9, 18.0, 18.4, 19.2, 19.4, 20.1];
    test('Mean 17.7, median 17.45, s² 2.4, SE 0.49 (pp.359–363)', () {
      expect(Stats.mean(holds), near(17.7));
      expect(Stats.median(holds), near(17.45));
      expect(Stats.sampleVariance(holds), near(2.4));
      expect(Stats.standardError(holds), near(0.4899, 0.001));
    });
    test('Weighted average bet \$416.67 vs \$110.42 (p.364)', () {
      expect(Stats.weightedAverageBet([(bet: 500, hours: 2), (bet: 450, hours: 4), (bet: 700, hours: 1), (bet: 300, hours: 5)]), near(416.67));
      expect(Stats.weightedAverageBet([(bet: 1700, hours: 0.25), (bet: 75, hours: 5), (bet: 75, hours: 6), (bet: 100, hours: 0.75)]), near(110.42));
    });
    test('Multi-spot BJ SD (p.369)', () {
      expect(Stats.bjMultiSpotSd(1), near(1.1225, 0.0001));
      expect(Stats.bjMultiSpotSd(7), near(5.4608, 0.0001));
    });
  });
}
