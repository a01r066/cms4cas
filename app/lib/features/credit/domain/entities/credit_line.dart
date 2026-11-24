import 'package:casino_engine/casino_engine.dart';

import 'credit_application.dart';
import 'credit_enums.dart';
import 'marker.dart';

typedef CreditLine = ({double line, double outstanding, double available});

/// Line available to a player: the larger of the latest approved permanent and
/// temporary lines, minus open marker balances. The issueMarker action applies
/// the same rule server-side.
CreditLine availableCredit(List<CreditApplication> apps, List<Marker> markers, String playerId) {
  final approved = apps.where((a) => a.playerId == playerId && a.status == CreditStatus.approved).toList();
  double latest(LineType t) {
    final l = approved.where((a) => a.lineType == t).toList()
      ..sort((a, b) => (b.decidedAt ?? b.createdAt).compareTo(a.decidedAt ?? a.createdAt));
    return l.isEmpty ? 0 : l.first.amount;
  }

  final perm = latest(LineType.permanent);
  final temp = latest(LineType.temporary);
  final line = temp > perm ? temp : perm;
  final out = markers.where((m) => m.playerId == playerId).fold<double>(0, (a, m) => a + m.balance);
  return (line: line, outstanding: out, available: (line - out).clamp(0, double.infinity).toDouble());
}
