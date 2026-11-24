import 'book_ref.dart';

class SportsBook {
  static const ref = BookRef(17, '324–338', 'Money lines, ideal balance, parlays');

  static ({double favorite, double underdog}) lineFromOdds(double fav, double dog, {double lineCents = 10}) {
    final t = fav / dog * 100;
    return (favorite: -(t + lineCents / 2), underdog: t - lineCents / 2);
  }

  static double breakEvenPct(double cost) => cost / (cost + 100);

  static ({double share, double bookAdvantage}) idealBalance(double favLine, double dogLine) {
    final f = favLine / (favLine + 100), d = 100 / (100 + dogLine);
    final s = f / (f + d);
    return (share: s, bookAdvantage: 1 - (s * (100 / favLine) + s));
  }

  static double lineMove(double lineSizeCents) => lineSizeCents < 40 ? lineSizeCents / 2 : lineSizeCents / 4;

  static double parlayEdge(int teams, double paysForOne) {
    var p = 1.0;
    for (var i = 0; i < teams; i++) {
      p *= 0.5;
    }
    return -(p * (paysForOne - 1) - (1 - p));
  }
}
