import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/auth/roles.dart';
import '../../../core/auth/session.dart';
import '../../../core/data/repository.dart';
import '../../../core/util/fmt.dart';
import '../../../core/widgets/widgets.dart';
import '../../settings/data/settings.dart';
import '../data/table_models.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});
  @override
  Widget build(BuildContext context) => const DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(isScrollable: true, tabs: [Tab(text: 'Hold dashboard'), Tab(text: 'Record shift'), Tab(text: 'Hold tools')]),
          body: TabBarView(children: [_HoldDashboard(), _RecordShift(), _HoldTools()]),
        ),
      );
}

class _HoldDashboard extends ConsumerStatefulWidget {
  const _HoldDashboard();
  @override
  ConsumerState<_HoldDashboard> createState() => _HoldDashboardState();
}

class _HoldDashboardState extends ConsumerState<_HoldDashboard> {
  int days = 30;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final tables = ref.watch(tablesProvider).value ?? const <TableDef>[];
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final shifts = (ref.watch(shiftsProvider).value ?? const <TableShift>[]).where((s) => s.gamingDay.isAfter(cutoff)).toList();
    final hits = (ref.watch(hitsProvider).value ?? const <HitRecord>[]).where((h) => h.gamingDay.isAfter(cutoff)).toList();
    final settings = ref.watch(settingsProvider);
    final all = HoldSummary.of(shifts, hits);
    return PageBody(children: [
      Wrap(spacing: 12, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
        Text('Table games — last $days days', style: Theme.of(context).textTheme.titleLarge),
        SegmentedButton<int>(
          segments: const [ButtonSegment(value: 1, label: Text('1d')), ButtonSegment(value: 7, label: Text('7d')), ButtonSegment(value: 30, label: Text('30d')), ButtonSegment(value: 365, label: Text('1y'))],
          selected: {days},
          onSelectionChanged: (s) => setState(() => days = s.first),
        ),
      ]),
      const SizedBox(height: 12),
      MetricGrid([
        Metric('Drop', money0(all.drop)),
        Metric('Win', money0(all.win), color: all.win < 0 ? Colors.red.shade700 : null),
        Metric('Hold (win ÷ drop)', pct(all.hold, 1)),
        Metric('Statistical hold', pct(all.statHold, 1), note: 'Incl. markers repaid in pit with cheques'),
        Metric('Hold excl. documented hits', pct(all.adjustedHold, 1), note: '${hits.length} hit(s) removed'),
      ]),
      const SizedBox(height: 12),
      Callout('Hold reflects count timing, credit policy, occupancy, cash play and promotions as much as staff performance — '
          'check the hold tools before drawing conclusions (Ch13). NV requires investigating moves beyond ±${pct(settings.holdTolerance, 0)} from the base hold.'),
      SectionCard(
        title: 'By table',
        trailing: user?.can(Perm.tableAccounting) == true
            ? FilledButton.tonalIcon(onPressed: () => _editTable(context, ref), icon: const Icon(Icons.add), label: const Text('Add table'))
            : null,
        children: [
          if (tables.isEmpty) const EmptyState('No tables yet. Add your tables, then record shifts.', icon: Icons.table_restaurant),
          if (tables.isNotEmpty)
            SimpleTable(
              columns: const ['Table', 'Game', 'Shifts', 'Drop', 'Win', 'Hold', 'Stat. hold', 'Base', 'Flag'],
              rows: [
                for (final t in tables)
                  () {
                    final s = HoldSummary.of(shifts.where((x) => x.tableId == t.id).toList(), hits.where((x) => x.tableId == t.id).toList());
                    final n = shifts.where((x) => x.tableId == t.id).length;
                    final flag = n > 0 && t.baseHold > 0 && TableGames.needsInvestigation(s.statHold, t.baseHold, tolerance: settings.holdTolerance);
                    return <Widget>[
                      Text(t.name), Text(settings.game(t.gameId).name), Text('$n'), Text(money0(s.drop)), Text(money0(s.win)),
                      Text(n == 0 ? '—' : pct(s.hold, 1)), Text(n == 0 ? '—' : pct(s.statHold, 1)), Text(t.baseHold == 0 ? '—' : pct(t.baseHold, 1)),
                      flag ? Text('Investigate', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w600)) : const Text(''),
                    ];
                  }()
              ],
              onTap: [for (final t in tables) user?.can(Perm.tableAccounting) == true ? () => _editTable(context, ref, t) : null],
            ),
        ],
      ),
      SectionCard(title: 'Recent shifts', children: [
        if (shifts.isEmpty) const Text('No shifts in this period.'),
        if (shifts.isNotEmpty)
          SimpleTable(columns: const ['Gaming day', 'Shift', 'Table', 'Drop', 'Missing', 'Win', 'Hold', 'By'], rows: [
            for (final s in shifts.take(50))
              [
                Text(date(s.gamingDay)), Text(s.shift), Text(tables.where((t) => t.id == s.tableId).map((t) => t.name).firstOrNull ?? '?'),
                Text(money0(s.result.drop)), Text(money0(s.result.chequesMissing)), Text(money0(s.result.win)), Text(pct(s.result.hold, 1)), Text(s.recordedBy),
              ]
          ]),
      ]),
      const Refs([TableGames.refWin, TableGames.refDeterminants, BookRef(10, '204–205', 'Statistical reports and ±3% rule')]),
    ]);
  }
}

Future<void> _editTable(BuildContext context, WidgetRef ref, [TableDef? t]) async {
  final settings = ref.read(settingsProvider);
  final name = TextEditingController(text: t?.name);
  final pit = TextEditingController(text: t?.pit);
  final min = TextEditingController(text: t == null ? '' : numf(t.minBet));
  final max = TextEditingController(text: t == null ? '' : numf(t.maxBet));
  final base = TextEditingController(text: t == null || t.baseHold == 0 ? '' : (t.baseHold * 100).toStringAsFixed(1));
  var game = t?.gameId ?? 'blackjack';
  var system = t?.system ?? MarkerSystem.marker;
  final form = GlobalKey<FormState>();
  await showDialog<void>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, set) => AlertDialog(
        title: Text(t == null ? 'Add table' : 'Edit ${t.name}'),
        content: SizedBox(
          width: 440,
          child: Form(
            key: form,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Table name / number *'), validator: (v) => (v ?? '').trim().isEmpty ? 'Required' : null),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: game,
                  decoration: const InputDecoration(labelText: 'Game'),
                  items: settings.games.map((g) => DropdownMenuItem(value: g.id, child: Text(g.name))).toList(),
                  onChanged: (v) => game = v!,
                ),
                TextFormField(controller: pit, decoration: const InputDecoration(labelText: 'Pit')),
                NumField(label: 'Minimum bet', controller: min, prefix: '\$ ', min: 0, required: false),
                NumField(label: 'Maximum bet', controller: max, prefix: '\$ ', min: 0, required: false),
                NumField(label: 'Base statistical hold', controller: base, suffix: '%', min: 0, max: 100, required: false, helper: 'Prior year win ÷ statistical drop (used for the ±3% rule)'),
                DropdownButtonFormField<MarkerSystem>(
                  isExpanded: true,
                  initialValue: system,
                  decoration: const InputDecoration(labelText: 'Credit system'),
                  items: const [
                    DropdownMenuItem(value: MarkerSystem.marker, child: Text('Marker system (redeem in pit)')),
                    DropdownMenuItem(value: MarkerSystem.nameCredit, child: Text('Name credit (redeem at cage only)')),
                  ],
                  onChanged: (v) => set(() => system = v!),
                ),
              ]),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              if (!form.currentState!.validate()) return;
              final id = t?.id ?? Repository.newId();
              final def = TableDef(
                id: id, name: name.text.trim(), gameId: game, pit: pit.text.trim(), minBet: parseNum(min.text) ?? 0,
                maxBet: parseNum(max.text) ?? 0, baseHold: (parseNum(base.text) ?? 0) / 100, system: system,
              );
              final r = await ref.read(tablesRepoProvider).save(id, def);
              if (!ctx.mounted) return;
              r.fold((f) => showMsg(ctx, f.displayMessage, error: true), (_) => Navigator.pop(ctx));
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
}

class _RecordShift extends ConsumerStatefulWidget {
  const _RecordShift();
  @override
  ConsumerState<_RecordShift> createState() => _RecordShiftState();
}

class _RecordShiftState extends ConsumerState<_RecordShift> {
  final form = GlobalKey<FormState>();
  String? tableId;
  String shift = 'Day';
  DateTime day = DateTime.now();
  final c = {
    for (final k in ['open', 'fills', 'credits', 'close', 'currency', 'cheques', 'issued', 'redCash', 'redCheques']) k: TextEditingController(text: '0'),
  };

  TableShiftInput _input(MarkerSystem sys) => TableShiftInput(
        openingInventory: parseNum(c['open']!.text) ?? 0, fills: parseNum(c['fills']!.text) ?? 0, credits: parseNum(c['credits']!.text) ?? 0,
        closingInventory: parseNum(c['close']!.text) ?? 0, currencyInBox: parseNum(c['currency']!.text) ?? 0, chequesInBox: parseNum(c['cheques']!.text) ?? 0,
        markersIssued: parseNum(c['issued']!.text) ?? 0, markersRedeemedInPitCash: parseNum(c['redCash']!.text) ?? 0,
        markersRedeemedInPitCheques: parseNum(c['redCheques']!.text) ?? 0, system: sys,
      );

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    if (user == null || !user.can(Perm.tableAccounting)) return const PageBody(children: [NoAccess('recording table shifts')]);
    final tables = ref.watch(tablesProvider).value ?? const <TableDef>[];
    if (tables.isEmpty) return const PageBody(children: [EmptyState('Add a table on the Hold dashboard first.', icon: Icons.table_restaurant)]);
    final t = tables.where((x) => x.id == tableId).firstOrNull;
    final sys = t?.system ?? MarkerSystem.marker;
    final i = _input(sys);
    final r = TableGames.compute(i);
    final errs = i.validate();
    return PageBody(maxWidth: 950, children: [
      Form(
        key: form,
        onChanged: () => setState(() {}),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SectionCard(title: 'Shift', children: [
            FieldGrid(children: [
              DropdownButtonFormField<String>(
                  isExpanded: true,
                initialValue: tableId,
                decoration: const InputDecoration(labelText: 'Table *'),
                items: tables.map((t) => DropdownMenuItem(value: t.id, child: Text(t.name))).toList(),
                onChanged: (v) => setState(() => tableId = v),
                validator: (v) => v == null ? 'Choose a table' : null,
              ),
              DropdownButtonFormField<String>(
                  isExpanded: true,
                initialValue: shift,
                decoration: const InputDecoration(labelText: 'Shift', helperText: 'Use "Gaming day" for once-a-day drops (p.172)'),
                items: const ['Day', 'Swing', 'Graveyard', 'Gaming day'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => shift = v!),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.event),
                label: Text('Gaming day ${date(day)}'),
                onPressed: () async {
                  final d = await showDatePicker(context: context, initialDate: day, firstDate: DateTime(2020), lastDate: DateTime.now().add(const Duration(days: 1)));
                  if (d != null) setState(() => day = d);
                },
              ),
            ]),
          ]),
          SectionCard(title: 'Chip inventory (opener / closer)', subtitle: 'Counted by dealer and floorperson; closer becomes next opener (p.167)', children: [
            FieldGrid(children: [
              NumField(label: 'Opening inventory', controller: c['open']!, prefix: '\$ ', min: 0),
              NumField(label: 'Fills (cage → table)', controller: c['fills']!, prefix: '\$ ', min: 0),
              NumField(label: 'Credits (table → cage)', controller: c['credits']!, prefix: '\$ ', min: 0),
              NumField(label: 'Closing inventory', controller: c['close']!, prefix: '\$ ', min: 0),
            ]),
          ]),
          SectionCard(title: 'Drop box and credit', children: [
            FieldGrid(children: [
              NumField(label: 'Currency in drop box', controller: c['currency']!, prefix: '\$ ', min: 0),
              NumField(label: 'Cheques in drop box', controller: c['cheques']!, prefix: '\$ ', min: 0, helper: 'Foreign chips / coupons dropped'),
              NumField(label: 'Markers issued at table', controller: c['issued']!, prefix: '\$ ', min: 0),
              if (sys == MarkerSystem.marker) ...[
                NumField(label: 'Markers redeemed in pit — cash', controller: c['redCash']!, prefix: '\$ ', min: 0),
                NumField(label: 'Markers redeemed in pit — cheques', controller: c['redCheques']!, prefix: '\$ ', min: 0),
              ],
            ]),
            if (sys == MarkerSystem.nameCredit) const Padding(padding: EdgeInsets.only(top: 8), child: Text('Name credit system: markers can only be redeemed at the cage (p.171).')),
          ]),
        ]),
      ),
      SectionCard(title: 'Result', children: [
        for (final e in errs) Callout.warn(e),
        MetricGrid([
          Metric('Drop', money0(r.drop), note: 'cash + cheques + markers issued − redeemed in pit'),
          Metric('Cheques missing', money0(r.chequesMissing), note: 'opener + fills − credits − closer'),
          Metric('Win', money0(r.win), color: r.win < 0 ? Colors.red.shade700 : null),
          Metric('Hold', pct(r.hold, 1)),
          Metric('Statistical drop', money0(r.statisticalDrop)),
          Metric('Statistical hold', pct(r.statisticalHold, 1)),
        ]),
        const SizedBox(height: 8),
        const BookRefChip(TableGames.refWin),
      ]),
      Align(
        alignment: Alignment.centerRight,
        child: FilledButton.icon(
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save shift'),
          onPressed: () async {
            if (!form.currentState!.validate() || errs.isNotEmpty) return;
            final id = Repository.newId();
            final s = TableShift(id: id, tableId: tableId!, shift: shift, recordedBy: user.name, gamingDay: DateTime(day.year, day.month, day.day), recordedAt: DateTime.now(), input: i);
            final out = await ref.read(shiftsRepoProvider).save(id, s);
            if (!context.mounted) return;
            out.fold((f) => showMsg(context, f.displayMessage, error: true), (_) {
              showMsg(context, 'Shift saved — win ${money0(s.result.win)}, hold ${pct(s.result.hold, 1)}');
              setState(() {
                c['open']!.text = numf(i.closingInventory).replaceAll(',', '');
                for (final k in ['fills', 'credits', 'close', 'currency', 'cheques', 'issued', 'redCash', 'redCheques']) {
                  c[k]!.text = '0';
                }
              });
            });
          },
        ),
      ),
    ]);
  }
}

class _HoldTools extends ConsumerStatefulWidget {
  const _HoldTools();
  @override
  ConsumerState<_HoldTools> createState() => _HoldToolsState();
}

class _HoldToolsState extends ConsumerState<_HoldTools> {
  final objective = TextEditingController(text: '20');
  final ha = TextEditingController(text: '1');
  final checks = <int>{};
  String? hitTable;
  final hitPlayer = TextEditingController();
  final hitDrop = TextEditingController();
  final hitResult = TextEditingController();
  DateTime hitDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final o = (parseNum(objective.text) ?? 0) / 100, h = (parseNum(ha.text) ?? 0) / 100;
    final tables = ref.watch(tablesProvider).value ?? const <TableDef>[];
    final hits = ref.watch(hitsProvider).value ?? const <HitRecord>[];
    final user = ref.watch(currentUserProvider);
    final settings = ref.watch(settingsProvider);
    return PageBody(maxWidth: 950, children: [
      SectionCard(title: 'Hold diagnostics checklist', subtitle: 'Review these before reading anything into a hold change', children: [
        for (var k = 0; k < TableGames.holdDiagnostics.length; k++)
          CheckboxListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            value: checks.contains(k),
            onChanged: (v) => setState(() => v! ? checks.add(k) : checks.remove(k)),
            title: Text(TableGames.holdDiagnostics[k].$1),
            subtitle: Text(TableGames.holdDiagnostics[k].$2),
          ),
        Text('${checks.length} of ${TableGames.holdDiagnostics.length} reviewed'),
        const SizedBox(height: 8),
        const BookRefChip(TableGames.refDeterminants),
      ]),
      SectionCard(title: 'Hold objective', subtitle: 'How many times the buy-in must be wagered to reach a hold target (p.249)', children: [
        FieldGrid(children: [
          NumField(label: 'Hold objective', controller: objective, suffix: '%', min: 0.1, onChanged: (_) => setState(() {})),
          NumField(label: 'House advantage per hand', controller: ha, suffix: '%', min: 0.01, onChanged: (_) => setState(() {})),
          Metric('Wagers needed', h > 0 ? '${TableGames.wagerMultipleForHold(o, h).toStringAsFixed(2)} × buy-in' : '—'),
        ]),
        const BookRefChip(TableGames.refObjective),
      ]),
      SectionCard(title: 'Documented hits', subtitle: 'Large observed wins/losses (≥ ${money0(settings.ratingHitThreshold)}) are excluded from hold analysis (p.249)', children: [
        if (user?.can(Perm.tableAccounting) == true && tables.isNotEmpty) ...[
          FieldGrid(children: [
            DropdownButtonFormField<String>(
                  isExpanded: true,
              initialValue: hitTable,
              decoration: const InputDecoration(labelText: 'Table'),
              items: tables.map((t) => DropdownMenuItem(value: t.id, child: Text(t.name))).toList(),
              onChanged: (v) => setState(() => hitTable = v),
            ),
            TextField(controller: hitPlayer, decoration: const InputDecoration(labelText: 'Player')),
            NumField(label: "Player's drop (buy-in)", controller: hitDrop, prefix: '\$ ', min: 0),
            NumField(label: 'Casino result (+ player lost)', controller: hitResult, prefix: '\$ ', min: -100000000),
          ]),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonal(
              onPressed: () async {
                final d = parseNum(hitDrop.text), r = parseNum(hitResult.text);
                if (hitTable == null || d == null || r == null || hitPlayer.text.trim().isEmpty) {
                  showMsg(context, 'Fill in table, player, drop and result.', error: true);
                  return;
                }
                if (r.abs() < settings.ratingHitThreshold) {
                  showMsg(context, 'Below the hit threshold of ${money0(settings.ratingHitThreshold)} — not excluded.', error: true);
                  return;
                }
                final id = Repository.newId();
                await ref.read(hitsRepoProvider).save(id, HitRecord(id: id, tableId: hitTable!, playerLabel: hitPlayer.text.trim(), gamingDay: hitDay, playerDrop: d, casinoResult: r, recordedBy: user!.name));
                if (context.mounted) showMsg(context, 'Hit recorded');
                hitPlayer.clear();
                hitDrop.clear();
                hitResult.clear();
              },
              child: const Text('Record hit'),
            ),
          ),
        ],
        if (hits.isNotEmpty)
          SimpleTable(columns: const ['Day', 'Table', 'Player', 'Drop', 'Casino result'], rows: [
            for (final x in hits)
              [Text(date(x.gamingDay)), Text(tables.where((t) => t.id == x.tableId).map((t) => t.name).firstOrNull ?? '?'), Text(x.playerLabel), Text(money0(x.playerDrop)), Text(money0(x.casinoResult))]
          ]),
        const BookRefChip(TableGames.refHits),
      ]),
    ]);
  }
}
