import 'dart:math' as math;
import 'book_ref.dart';

class Slots {
  static const ref = BookRef(7, '113–140', 'Slot management');

  /// Slot win = drop − jackpots − fills − progressive accrual (p.134).
  static double win({required double drop, required double jackpots, required double fills, double progressiveAccrual = 0}) =>
      drop - jackpots - fills - progressiveAccrual;

  /// Nevada tax basis excludes progressive accrual (p.135).
  static double winForTax({required double drop, required double jackpots, required double fills}) =>
      drop - jackpots - fills;

  static double hold(double win, double coinIn) => coinIn == 0 ? 0 : win / coinIn;

  /// Hit frequency = paying pulls / pulls in a cycle (p.117).
  static double hitFrequency(int payingPulls, int cyclePulls) => payingPulls / cyclePulls;

  /// Volatility index V.I. = z·σ; σ = √Σ(net − EV)²·p (pp.126–128).
  static ({double vi, double variance}) volatilityIndex(List<({double net, int hits})> pays, double ev, {double z = 1.65}) {
    final total = pays.fold<int>(0, (a, p) => a + p.hits);
    final v = pays.fold<double>(0, (a, p) => a + (p.net - ev) * (p.net - ev) * p.hits / total);
    return (vi: z * math.sqrt(v), variance: v);
  }

  /// Acceptable payback range after [games] pulls: payback ± V.I./√games (p.129).
  /// [payback] and [vi] in the same unit (fraction or percent).
  static ({double low, double high}) paybackRange(double payback, double vi, int games) {
    final d = vi / math.sqrt(games);
    return (low: payback - d, high: payback + d);
  }

  /// Elementary PRNG from p.139: z ← 6z mod 13.
  static List<int> lcg6z13(int seed, int n) {
    final out = <int>[];
    var z = seed;
    for (var i = 0; i < n; i++) {
      z = (6 * z) % 13;
      out.add(z);
    }
    return out;
  }
}
