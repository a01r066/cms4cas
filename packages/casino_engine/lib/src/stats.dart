import 'dart:math' as math;
import 'book_ref.dart';

/// Ch19 statistics.
class Stats {
  static const ref = BookRef(19, '357–376', 'Casino statistics');

  static double mean(List<double> xs) => xs.reduce((a, b) => a + b) / xs.length;

  static double median(List<double> xs) {
    final s = [...xs]..sort();
    final n = s.length;
    return n.isOdd ? s[n ~/ 2] : (s[n ~/ 2 - 1] + s[n ~/ 2]) / 2;
  }

  /// Sample variance with n − 1 (p.361).
  static double sampleVariance(List<double> xs) {
    final m = mean(xs);
    return xs.map((x) => (x - m) * (x - m)).reduce((a, b) => a + b) / (xs.length - 1);
  }

  static double sampleSd(List<double> xs) => math.sqrt(sampleVariance(xs));

  /// Standard error of the mean = s / √n (p.362).
  static double standardError(List<double> xs) => sampleSd(xs) / math.sqrt(xs.length);

  /// Time-weighted average bet (p.364).
  static double weightedAverageBet(List<({double bet, double hours})> sessions) {
    final h = sessions.fold<double>(0, (a, s) => a + s.hours);
    if (h == 0) return 0;
    return sessions.fold<double>(0, (a, s) => a + s.bet * s.hours) / h;
  }

  /// SD of a session's result = √(Σ bet²·n) × SD per $1 (pp.285, 367–368).
  static double sessionSd(List<({double bet, int hands})> bets, double sdPerDollar) =>
      math.sqrt(bets.fold<double>(0, (a, b) => a + b.bet * b.bet * b.hands)) * sdPerDollar;

  /// Blackjack variance per round with n spots: 1.26n + 0.5n(n−1) (p.369).
  static double bjMultiSpotSd(int spots) => math.sqrt(1.26 * spots + 0.5 * spots * (spots - 1));

  /// Standard normal CDF (Appendix z table equivalent, p.377).
  static double normalCdf(double z) => 0.5 * (1 + _erf(z / math.sqrt2));

  static double normalPdf(double z) => math.exp(-z * z / 2) / math.sqrt(2 * math.pi);

  static double _erf(double x) {
    // Abramowitz–Stegun 7.1.26, max error 1.5e-7.
    final s = x < 0 ? -1.0 : 1.0;
    x = x.abs();
    final t = 1 / (1 + 0.3275911 * x);
    final y = 1 -
        (((((1.061405429 * t - 1.453152027) * t) + 1.421413741) * t - 0.284496736) * t +
                0.254829592) *
            t *
            math.exp(-x * x);
    return s * y;
  }

  /// Log-gamma (Lanczos) for exact multinomial probabilities.
  static double lgamma(double x) {
    const g = 7.0;
    const c = [
      0.99999999999980993, 676.5203681218851, -1259.1392167224028, 771.32342877765313,
      -176.61502916214059, 12.507343278686905, -0.13857109526572012,
      9.9843695780195716e-6, 1.5056327351493116e-7
    ];
    if (x < 0.5) return math.log(math.pi / math.sin(math.pi * x)) - lgamma(1 - x);
    x -= 1;
    var a = c[0];
    final t = x + g + 0.5;
    for (var i = 1; i < 9; i++) {
      a += c[i] / (x + i);
    }
    return 0.5 * math.log(2 * math.pi) + (x + 0.5) * math.log(t) - t + math.log(a);
  }

  static int comb(int n, int k) {
    if (k < 0 || k > n) return 0;
    var r = 1;
    for (var i = 1; i <= k; i++) {
      r = r * (n - k + i) ~/ i;
    }
    return r;
  }
}
