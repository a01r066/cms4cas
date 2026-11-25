import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/route_names.dart';
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
import '../../../tables/domain/entities/table_def.dart';
import '../../../tables/presentation/providers/tables_providers.dart';
import '../../../tables/presentation/widgets/hold_chart.dart';

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
    String n(int count, String one, String many) => count == 1 ? '1 $one' : '$count $many';
    final attention = <(Tone, String, String)>[
      if (reportable.isNotEmpty)
        (Tone.bad, '${n(reportable.length, 'patron is', 'patrons are')} over the ${money0(s.aml.ctrThreshold)} CTR threshold today', Routes.compliance),
      if (sarDue > 0) (Tone.warn, '${n(sarDue, 'SAR case is', 'SAR cases are')} due within 7 days', Routes.compliance),
      if (pending.isNotEmpty) (Tone.warn, '${n(pending.length, 'credit application is', 'credit applications are')} awaiting signatures', Routes.credit),
    ];

    if (isDesktop(context)) {
      final tables = ref.watch(tablesProvider).value ?? const <TableDef>[];
      final base = {for (final t in tables) t.id: t.baseHold};
      final objective7 = last7.fold<double>(0, (a, x) => a + (base[x.tableId] ?? 0) * x.result.drop) / (hold.drop == 0 ? 1 : hold.drop);
      final prevRatings = ratings.where((r) =>
          r.at.isAfter(DateTime.now().subtract(const Duration(hours: 48))) && !r.at.isAfter(DateTime.now().subtract(const Duration(hours: 24))));
      final theoPrev = prevRatings.fold<double>(0, (a, r) => a + r.theo);
      final over60 = markers.where((m) => m.balance > 0 && DateTime.now().difference(m.issuedAt).inDays > 60).fold<double>(0, (a, m) => a + m.balance);
      final series = DailyHold.series(shifts, base, today: today);
      return _DesktopHome(
        title: _longDate(today),
        subtitle: '${s.casinoName} · ${user?.name ?? ''}, ${user?.role.label ?? ''}',
        metrics: [
          Metric('Theo rated, last 24 h', money0(theo24),
              note: '${n(todaysRatings.length, 'session', 'sessions')} · ${money0(theoPrev)} the 24 h before'),
          Metric('Table hold, last 7 days', last7.isEmpty ? '—' : pct(hold.hold, 1),
              note: last7.isEmpty ? 'No shifts recorded' : 'Objective ${pct(objective7, 1)} · drop ${money0(hold.drop)}'),
          Metric('Outstanding markers', money0(outstanding),
              note: '${n(markers.where((m) => m.balance > 0).length, 'open marker', 'open markers')} · ${money0(over60)} over 60 days'),
          Metric('CTRs in progress', '$ctrOpen', note: '${n(reportable.length, 'reportable total', 'reportable totals')} today'),
        ],
        chart: tables.isEmpty
            ? const EmptyState('Add tables and record shifts to see hold by gaming day.', icon: Icons.table_restaurant_outlined)
            : HoldChart(days: series, tolerance: s.holdTolerance, height: 220),
        attention: attention,
      );
    }

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
          for (final a in attention) a.$1 == Tone.bad ? Callout.bad(a.$2) : Callout.warn(a.$2),
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

const _weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
const _months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
String _longDate(DateTime d) => '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';

class _DesktopHome extends StatelessWidget {
  const _DesktopHome({required this.title, required this.subtitle, required this.metrics, required this.chart, required this.attention});

  final String title, subtitle;
  final List<Metric> metrics;
  final Widget chart;
  final List<(Tone, String, String)> attention;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final chartCard = SectionCard(
      title: 'Table hold by gaming day',
      subtitle: 'Last 14 gaming days · hover a day for its figures',
      children: [chart],
    );
    final attentionCard = SectionCard(
      title: 'Needs attention',
      children: [
        if (attention.isEmpty) Text('Nothing is waiting on you', style: t.textTheme.bodyMedium?.copyWith(color: t.colorScheme.onSurfaceVariant)),
        for (final (i, a) in attention.indexed) ...[
          if (i > 0) const Divider(height: 1),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => context.go(a.$3),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(width: 7, height: 7, decoration: BoxDecoration(color: StatusText.colorOf(context, a.$1), shape: BoxShape.circle)),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(a.$2)),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right_rounded, size: 18, color: t.colorScheme.onSurfaceVariant),
              ]),
            ),
          ),
        ],
      ],
    );
    return Scaffold(
      body: PageBody(children: [
        LayoutBuilder(builder: (context, c) {
          final head = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: t.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(subtitle, style: t.textTheme.bodyMedium?.copyWith(color: t.colorScheme.onSurfaceVariant)),
          ]);
          final actions = Wrap(spacing: 8, runSpacing: 8, children: [
            OutlinedButton.icon(onPressed: () => context.go(Routes.tables), icon: const Icon(Icons.table_restaurant_outlined, size: 18), label: const Text('Record a shift')),
            FilledButton.icon(onPressed: () => context.go(Routes.players), icon: const Icon(Icons.add_rounded, size: 18), label: const Text('Rate a player')),
          ]);
          return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Expanded(child: head), actions]);
        }),
        const SizedBox(height: 24),
        MetricGrid(metrics),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (context, c) {
          if (c.maxWidth < 1000) return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [chartCard, attentionCard]);
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 2, child: chartCard),
            const SizedBox(width: 16),
            Expanded(child: attentionCard),
          ]);
        }),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: Text('Every calculation follows Kilby, Fox & Lucas, Casino Operations Management, 2nd ed. Select a citation to see the page.',
                style: t.textTheme.bodySmall),
          ),
        ]),
      ]),
    );
  }
}
