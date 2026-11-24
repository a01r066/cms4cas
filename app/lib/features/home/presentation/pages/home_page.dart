import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
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

    final t = Theme.of(context);
    final pal = AppPalette.of(context);
    final hour = DateTime.now().hour;
    final greeting = 'Good ${hour < 12 ? 'morning' : hour < 18 ? 'afternoon' : 'evening'},';
    final alerts = reportable.length + sarDue + pending.length;

    return Scaffold(
      body: PageBody(children: [
        HeroCard(children: [
          Text(greeting, style: TextStyle(color: pal.onHero.withValues(alpha: 0.8), fontSize: 14)),
          const SizedBox(height: 2),
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 10, runSpacing: 6, children: [
            Text(user?.name ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            if (user != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Radii.pill),
                  border: Border.all(color: pal.accent.withValues(alpha: 0.6)),
                ),
                child: Text(user.role.label, style: TextStyle(color: pal.accent, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
          ]),
          const SizedBox(height: 20),
          Text('Outstanding markers', style: TextStyle(color: pal.onHero.withValues(alpha: 0.75), fontSize: 13)),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(money0(outstanding), style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
          ),
          const SizedBox(height: 4),
          Text('${s.casinoName} · gaming day ${date(today)}', style: TextStyle(color: pal.onHero.withValues(alpha: 0.75), fontSize: 13)),
          const SizedBox(height: 18),
          Wrap(spacing: 8, runSpacing: 8, children: [
            ElevatedButton.icon(
              onPressed: () => context.go('/players'),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Rate a player'),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white.withValues(alpha: 0.35))),
              onPressed: () => context.go('/tables'),
              icon: const Icon(Icons.north_east_rounded, size: 18),
              label: const Text('Record a shift'),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white.withValues(alpha: 0.35))),
              onPressed: () => context.go('/compliance'),
              icon: const Icon(Icons.payments_outlined, size: 18),
              label: const Text('Log cash'),
            ),
          ]),
        ]),
        SectionCard(title: 'Quick access', children: [
          LayoutBuilder(builder: (context, c) {
            final cols = c.maxWidth >= 700 ? 8 : 4;
            final tiles = [
              QuickTile(icon: Icons.people_outline, label: 'Players', onTap: () => context.go('/players')),
              QuickTile(icon: Icons.table_restaurant_outlined, label: 'Tables', onTap: () => context.go('/tables')),
              QuickTile(icon: Icons.credit_score_outlined, label: 'Credit', onTap: () => context.go('/credit')),
              QuickTile(icon: Icons.policy_outlined, label: 'Compliance', onTap: () => context.go('/compliance')),
              QuickTile(icon: Icons.calculate_outlined, label: 'Promotions', onTap: () => context.go('/evaluate')),
              QuickTile(icon: Icons.groups_2_outlined, label: 'Staffing', onTap: () => context.go('/staffing')),
              QuickTile(icon: Icons.menu_book_outlined, label: 'Library', onTap: () => context.go('/library')),
              QuickTile(icon: Icons.settings_outlined, label: 'Settings', onTap: () => context.go('/settings')),
            ];
            return Wrap(children: [for (final tile in tiles) SizedBox(width: c.maxWidth / cols, child: tile)]);
          }),
        ]),
        if (alerts > 0) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('Needs attention', style: t.textTheme.titleMedium),
          ),
          if (reportable.isNotEmpty) Callout.bad('${reportable.length} patron total(s) exceed the ${money0(s.aml.ctrThreshold)} reporting threshold today.'),
          if (sarDue > 0) Callout.warn('$sarDue suspicious-activity case(s) due within 7 days.'),
          if (pending.isNotEmpty) Callout.warn('${pending.length} credit application(s) awaiting signatures.'),
          const SizedBox(height: 8),
        ],
        Padding(padding: const EdgeInsets.only(bottom: 8), child: Text('Today at a glance', style: t.textTheme.titleMedium)),
        MetricGrid([
          Metric('Theo rated (24h)', money0(theo24), icon: Icons.trending_up_rounded, note: '${todaysRatings.length} sessions'),
          Metric('Table hold (7d)', last7.isEmpty ? '—' : pct(hold.hold, 1), icon: Icons.donut_large_rounded,
              note: last7.isEmpty ? 'no shifts recorded' : 'drop ${money0(hold.drop)}'),
          Metric('Outstanding markers', money0(outstanding), icon: Icons.receipt_long_outlined, note: '${markers.where((m) => m.balance > 0).length} open'),
          Metric('CTRs in progress', '$ctrOpen', icon: Icons.assignment_outlined),
        ]),
        const SizedBox(height: 24),
        Text('Every calculation follows Kilby, Fox & Lucas, Casino Operations Management (2nd ed.). Tap a "Book" chip to see the page.',
            style: t.textTheme.bodySmall),
      ]),
    );
  }
}
