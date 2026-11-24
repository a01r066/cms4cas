import 'book_ref.dart';

class RaceBook {
  static const ref = BookRef(18, '343–354', 'Pari-mutuel and race book');

  /// Payout for a \$2 win bet: true odds × (1 − takeout), rounded down to breakage (pp.343–345).
  static double payoutPer2({required double pool, required double onHorse, double takeout = 0.15, double breakage = 0.20}) {
    final raw = 2 * pool / onHorse * (1 - takeout);
    return (raw / breakage + 1e-9).floorToDouble() * breakage;
  }

  static double houseQuinella(double win, double place) => win * 0.5 * place;
  static double houseTrifecta(double win, double place, double show) => win * place * show * 1.2;
}
