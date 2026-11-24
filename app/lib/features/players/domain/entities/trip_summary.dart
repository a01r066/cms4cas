import 'dart:math' as math;

import 'package:casino_engine/casino_engine.dart';

import 'rating_record.dart';

/// Totals over a player's rated sessions. Average bet is time-weighted (Ch19 p.364);
/// session variances add, so SD = √Σσ².
class TripSummary {
  const TripSummary(this.sessions, this.hours, this.theo, this.actualCasinoWin, this.weightedAvgBet, this.sd);

  final int sessions;
  final double hours, theo, actualCasinoWin, weightedAvgBet, sd;

  factory TripSummary.of(List<RatingRecord> r) {
    if (r.isEmpty) return const TripSummary(0, 0, 0, 0, 0, 0);
    final hours = r.fold<double>(0, (a, x) => a + x.hours);
    final variance = r.fold<double>(0, (a, x) => a + x.sd * x.sd);
    return TripSummary(
      r.length,
      hours,
      r.fold(0, (a, x) => a + x.theo),
      r.fold(0, (a, x) => a + x.actualCasinoWin),
      Stats.weightedAverageBet(r.map((x) => (bet: x.averageBet, hours: x.hours)).toList()),
      variance <= 0 ? 0 : math.sqrt(variance),
    );
  }
}
