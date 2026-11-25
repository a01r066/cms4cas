import 'package:casino_engine/casino_engine.dart';

import 'hit_record.dart';
import 'table_shift.dart';

/// Hold over a set of shifts, raw, statistical and excluding documented hits.
class HoldSummary {
  const HoldSummary(this.drop, this.win, this.statDrop, this.hitDrop, this.hitResult);

  final double drop, win, statDrop, hitDrop, hitResult;

  double get hold => drop == 0 ? 0 : win / drop;
  double get statHold => statDrop == 0 ? 0 : win / statDrop;
  double get adjustedHold {
    final r = TableGames.removeHit(totalWin: win, totalDrop: statDrop, playerDrop: hitDrop, casinoResult: hitResult);
    return r.drop <= 0 ? 0 : r.win / r.drop;
  }

  static HoldSummary of(List<TableShift> s, List<HitRecord> h) => HoldSummary(
        s.fold(0, (a, x) => a + x.result.drop),
        s.fold(0, (a, x) => a + x.result.win),
        s.fold(0, (a, x) => a + x.result.statisticalDrop),
        h.fold(0, (a, x) => a + x.playerDrop),
        h.fold(0, (a, x) => a + x.casinoResult),
      );
}

/// One gaming day of table results, for the hold chart.
class DailyHold {
  const DailyHold(this.day, this.drop, this.win, this.baseWeighted);

  final DateTime day;
  final double drop, win;

  /// Σ(base hold × drop) — divided by drop gives the drop-weighted objective.
  final double baseWeighted;

  double get hold => drop == 0 ? 0 : win / drop;
  double get objective => drop == 0 ? 0 : baseWeighted / drop;
  bool get hasPlay => drop > 0;

  /// The last [days] gaming days up to [today], oldest first; days without shifts are empty.
  static List<DailyHold> series(List<TableShift> shifts, Map<String, double> baseHoldByTable, {required DateTime today, int days = 14}) {
    DateTime d0(DateTime d) => DateTime(d.year, d.month, d.day);
    final end = d0(today);
    final out = <DateTime, List<double>>{
      for (var i = days - 1; i >= 0; i--) DateTime(end.year, end.month, end.day - i): [0, 0, 0],
    };
    for (final s in shifts) {
      final v = out[d0(s.gamingDay)];
      if (v == null) continue;
      final r = s.result;
      v[0] += r.drop;
      v[1] += r.win;
      v[2] += (baseHoldByTable[s.tableId] ?? 0) * r.drop;
    }
    return [for (final e in out.entries) DailyHold(e.key, e.value[0], e.value[1], e.value[2])];
  }
}
