import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/util/fmt.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../compliance/domain/entities/compliance_entities.dart';
import '../../../compliance/presentation/providers/compliance_providers.dart';
import '../../../credit/domain/entities/credit_application.dart';
import '../../../credit/domain/entities/credit_enums.dart';
import '../../../credit/domain/entities/marker.dart';
import '../../../credit/presentation/providers/credit_providers.dart';
import '../../../players/domain/entities/rating_record.dart';
import '../../../players/presentation/providers/players_providers.dart';
import '../../../settings/presentation/providers/settings_providers.dart';
import '../../../tables/domain/entities/hold_summary.dart';
import '../../../tables/domain/entities/table_shift.dart';
import '../../../tables/presentation/providers/tables_providers.dart';

/// Today's picture: what needs attention, drawn from live records.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserValueProvider);
    final s = ref.watch(settingsProvider);
    final txs = ref.watch(cashTxProvider).value ?? const <CashTxRecord>[];
    final ctrs = ref.watch(ctrProvider).value ?? const <CtrReport>[];
    final apps = ref.watch(creditAppsProvider).value ?? const <CreditApplication>[];
    final markers = ref.watch(markersProvider).value ?? const <Marker>[];
    final ratings = ref.watch(ratingsProvider).value ?? const <RatingRecord>[];
    final shifts = ref.watch(shiftsProvider).value ?? const <TableShift>[];
    final sars = ref.watch(sarProvider).value ?? const <SarCase>[];

    final today = Aml.gamingDay(DateTime.now(), s.aml.gamingDayStartHour);
    final todayTx = txs.where((t) => Aml.gamingDay(t.at, s.aml.gamingDayStartHour) == today).map((t) => t.tx).toList();
    final reportable = Aml.aggregate(todayTx, s.aml).where((a) => a.reportable).toList();
    final ctrOpen = ctrs.where((c) => c.status != CtrStatus.filed).length;
    final pending = apps.where((a) => a.status == CreditStatus.pendingApproval).toList();
    final outstanding = markers.fold<double>(0, (a, m) => a + m.balance);
    final todaysRatings = ratings.where((r) => r.at.isAfter(DateTime.now().subtract(const Duration(hours: 24)))).toList();
    final theo24 = todaysRatings.fold<double>(0, (a, r) => a + r.theo);
    final last7 = shifts.where((x) => x.gamingDay.isAfter(DateTime.now().subtract(const Duration(days: 7)))).toList();
    final hold = HoldSummary.of(last7, const []);
    final sarDue = sars.where((c) => c.filedAt == null && Aml.sarDueDate(c.detectedAt, s.aml, extended: c.extended).difference(DateTime.now()).inDays <= 7).length;

    return Scaffold(
      body: PageBody(children: [
        Text('Good ${DateTime.now().hour < 12 ? 'morning' : DateTime.now().hour < 18 ? 'afternoon' : 'evening'}, ${user?.name ?? ''}', style: Theme.of(context).textTheme.headlineSmall),
        Text('${s.casinoName} · ${user?.role.label ?? ''} · gaming day ${date(today)}'),
        const SizedBox(height: 16),
        if (reportable.isNotEmpty) Callout.bad('${reportable.length} patron total(s) exceed the ${money0(s.aml.ctrThreshold)} reporting threshold today.'),
        if (sarDue > 0) Callout.warn('$sarDue suspicious-activity case(s) due within 7 days.'),
        if (pending.isNotEmpty) Callout.warn('${pending.length} credit application(s) awaiting signatures.'),
        const SizedBox(height: 8),
        MetricGrid([
          Metric('Theo rated (24h)', money0(theo24), note: '${todaysRatings.length} sessions'),
          Metric('Table hold (7d)', last7.isEmpty ? '—' : pct(hold.hold, 1), note: last7.isEmpty ? 'no shifts recorded' : 'drop ${money0(hold.drop)}'),
          Metric('Outstanding markers', money0(outstanding)),
          Metric('CTRs in progress', '$ctrOpen'),
        ]),
        const SizedBox(height: 16),
        Text('Quick actions', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          ActionChip(avatar: const Icon(Icons.people_outline, size: 18), label: const Text('Rate a player'), onPressed: () => context.go('/players')),
          ActionChip(avatar: const Icon(Icons.table_restaurant_outlined, size: 18), label: const Text('Record a table shift'), onPressed: () => context.go('/tables')),
          ActionChip(avatar: const Icon(Icons.payments_outlined, size: 18), label: const Text('Log cash transaction'), onPressed: () => context.go('/compliance')),
          ActionChip(avatar: const Icon(Icons.credit_score_outlined, size: 18), label: const Text('Credit applications'), onPressed: () => context.go('/credit')),
          ActionChip(avatar: const Icon(Icons.calculate_outlined, size: 18), label: const Text('Evaluate a promotion'), onPressed: () => context.go('/evaluate')),
        ]),
        const SizedBox(height: 24),
        const Text('Every calculation follows Kilby, Fox & Lucas, Casino Operations Management (2nd ed.). Tap a "Book" chip to see the page.', style: TextStyle(fontSize: 12)),
      ]),
    );
  }
}
