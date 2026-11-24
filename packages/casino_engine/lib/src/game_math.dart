import 'book_ref.dart';
import 'stats.dart';

class GameMath {
  static const refDice = BookRef(11, '207–213', 'Dice mathematics');
  static const refBj = BookRef(11, '214–215', 'Blackjack rule adjustments (Table 11.5)');
  static const refBac = BookRef(11, '214–216', 'Baccarat mathematics');
  static const refKeno = BookRef(11, '216–218', 'Keno mathematics');

  static const pBank = 0.4585974, pPlayer = 0.4462466, pTie = 0.095156;

  /// Expected value of a bet: Σ p × payoff.
  static double ev(List<({double p, double payoff})> o) => o.fold(0, (a, x) => a + x.p * x.payoff);

  /// Pass line with x-times odds: 0.5090909 / (36 + 24x) (p.211).
  static double passLineWithOdds(double x) => 0.5090909 / (36 + 24 * x);

  /// Roulette: ways to win / total × pay − ways to lose / total (p.214).
  static double rouletteEdge({required int waysToWin, required double pays, int totalPockets = 38}) =>
      -((waysToWin / totalPockets) * pays - ((totalPockets - waysToWin) / totalPockets));

  /// Baccarat bank edge for a given commission (p.216, 299–300). Positive = house advantage.
  static double baccaratBankEdge({double commission = 0.05, bool includeTies = true}) {
    final b = includeTies ? pBank : pBank / (1 - pTie);
    final pl = includeTies ? pPlayer : pPlayer / (1 - pTie);
    return pl - b * (1 - commission);
  }

  static double baccaratPlayerEdge({bool includeTies = true}) =>
      includeTies ? pBank - pPlayer : (pBank - pPlayer) / (1 - pTie);

  /// Tie bet paying [forOne] for one (p.300).
  static double baccaratTieEdge(double forOne) => -(pTie * (forOne - 1) - pPlayer - pBank);

  /// Keno house edge for a pay table {catch: total paid per $1} (pp.216–218).
  static double kenoEdge(int spots, Map<int, double> paysPerDollar) {
    final total = Stats.comb(80, spots);
    var paid = 0.0;
    for (var c = 0; c <= spots; c++) {
      paid += Stats.comb(20, c) * Stats.comb(60, spots - c) * (paysPerDollar[c] ?? 0);
    }
    return (total - paid) / total;
  }

  /// Blackjack: base strip-rules edge by decks + rule variations (Table 11.5), in %.
  static const bjDecks = [1, 2, 3, 4, 5, 6, 7, 8];
  static const bjBase = [-0.01, 0.32, 0.43, 0.49, 0.52, 0.54, 0.56, 0.57];
  static const bjRules = <String, List<double>>{
    'No double on 11': [0.78, 0.70, 0.67, 0.65, 0.64, 0.64, 0.63, 0.63],
    'No double on 10': [0.52, 0.49, 0.48, 0.47, 0.46, 0.46, 0.46, 0.46],
    'No double on 9': [0.12, 0.09, 0.08, 0.08, 0.08, 0.08, 0.07, 0.07],
    'No double on 8': [0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01],
    'No soft doubling': [0.13, 0.11, 0.10, 0.09, 0.09, 0.09, 0.09, 0.09],
    'Double on 11 only': [0.77, 1.02, 1.10, 1.14, 1.16, 1.18, 1.19, 1.20],
    'Double on 10, 11 only': [0.25, 0.53, 0.62, 0.67, 0.70, 0.72, 0.73, 0.74],
    'Double on 9, 10, 11 only': [0.13, 0.44, 0.54, 0.59, 0.62, 0.64, 0.66, 0.67],
    'Double on 8, 9, 10, 11 only': [0.12, 0.43, 0.53, 0.58, 0.61, 0.63, 0.65, 0.66],
    'Dealer hits soft 17': [0.19, 0.21, 0.22, 0.22, 0.22, 0.22, 0.22, 0.22],
    'BJ pays 1:1': [2.32, 2.29, 2.28, 2.28, 2.27, 2.27, 2.26, 2.26],
    'BJ pays 6:5': [1.395, 1.373, 1.367, 1.363, 1.361, 1.360, 1.359, 1.358],
    'No hole card (lose doubles/splits to dealer BJ)': [0.11, 0.11, 0.11, 0.11, 0.11, 0.11, 0.11, 0.11],
    'Double on any number of cards': [-0.24, -0.23, -0.23, -0.23, -0.23, -0.22, -0.23, -0.22],
    'Resplit aces': [-0.03, -0.05, -0.06, -0.07, -0.07, -0.07, -0.08, -0.08],
    'Double after splitting': [-0.12, -0.13, -0.14, -0.14, -0.14, -0.14, -0.14, -0.14],
    'Double after splitting 11 only': [-0.06, -0.07, -0.07, -0.07, -0.07, -0.07, -0.07, -0.07],
    'Double after splitting 10, 11 only': [-0.11, -0.12, -0.12, -0.12, -0.12, -0.12, -0.12, -0.12],
    'Early surrender': [-0.62, -0.63, -0.63, -0.64, -0.63, -0.63, -0.64, -0.63],
    'Early surrender (dealer hits s17)': [-0.51, -0.50, -0.50, -0.50, -0.50, -0.50, -0.50, -0.50],
    'Late surrender': [-0.02, -0.05, -0.06, -0.07, -0.07, -0.07, -0.07, -0.07],
    'Late surrender (dealer hits s17)': [-0.15, -0.14, -0.13, -0.13, -0.13, -0.13, -0.12, -0.12],
    '6 card auto winner': [-0.04, -0.11, -0.13, -0.15, -0.15, -0.16, -0.16, -0.16],
    'BJ pays 2 to 1': [-2.32, -2.29, -2.28, -2.28, -2.27, -2.27, -2.27, -2.27],
    'Dealer BJ ties w/ player built 21': [-0.17, -0.17, -0.17, -0.17, -0.17, -0.17, -0.17, -0.17],
  };

  static double blackjackEdgePct(int decks, Iterable<String> rules) {
    final i = bjDecks.indexOf(decks.clamp(1, 8));
    return bjBase[i] + rules.fold<double>(0, (a, r) => a + (bjRules[r]?[i] ?? 0));
  }
}
