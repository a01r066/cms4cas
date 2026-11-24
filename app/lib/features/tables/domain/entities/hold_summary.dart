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
