import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/util/fmt.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/domain/entities/app_role.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../credit/domain/entities/credit_application.dart';
import '../../../credit/domain/entities/credit_enums.dart';
import '../../../credit/presentation/providers/credit_providers.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/rating_record.dart';
import '../../domain/entities/trip_summary.dart';
import '../providers/players_notifier.dart';
import '../providers/players_providers.dart';
import '../../../settings/domain/entities/app_settings.dart';
import '../../../settings/presentation/providers/settings_providers.dart';

class PlayersPage extends ConsumerStatefulWidget {
  const PlayersPage({super.key});
  @override
  ConsumerState<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends ConsumerState<PlayersPage> {
  String q = '';
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserValueProvider);
    final players = ref.watch(playersProvider);
    final ratings = ref.watch(ratingsProvider).value ?? const <RatingRecord>[];
    return Scaffold(
      floatingActionButton: user?.can(Perm.managePlayers) == true
          ? FloatingActionButton.extended(
              onPressed: () => showPlayerForm(context, ref), icon: const Icon(Icons.person_add), label: const Text('Add player'))
          : null,
      body: PageBody(children: [
        TextField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search by name or player number'),
          onChanged: (v) => setState(() => q = v.toLowerCase()),
        ),
        const SizedBox(height: 16),
        players.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Callout.bad('Could not load players: $e'),
          data: (list) {
            final f = list.where((p) => p.name.toLowerCase().contains(q) || p.playerNo.toLowerCase().contains(q)).toList();
            if (f.isEmpty) {
              return EmptyState(list.isEmpty ? 'No players yet. Add the first player to start rating play.' : 'No match for "$q".',
                  icon: Icons.people_outline);
            }
            return Card(
              child: Column(children: [
                for (final p in f)
                  Builder(builder: (_) {
                    final r = ratings.where((x) => x.playerId == p.id).toList();
                    final s = TripSummary.of(r);
                    return ListTile(
                      leading: CircleAvatar(child: Text(p.name.isEmpty ? '?' : p.name[0].toUpperCase())),
                      title: Text(p.name),
                      subtitle: Text([
                        if (p.playerNo.isNotEmpty) '#${p.playerNo}',
                        '${s.sessions} rated session${s.sessions == 1 ? '' : 's'}',
                        if (s.sessions > 0) 'theo ${money0(s.theo)}',
                      ].join(' · ')),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.go(Routes.player(p.id)),
                    );
                  }),
              ]),
            );
          },
        ),
      ]),
    );
  }
}

Future<Player?> showPlayerForm(BuildContext context, WidgetRef ref, {Player? existing}) {
  final name = TextEditingController(text: existing?.name);
  final no = TextEditingController(text: existing?.playerNo);
  final idDoc = TextEditingController(text: existing?.idDocument);
  final addr = TextEditingController(text: existing?.address);
  final notes = TextEditingController(text: existing?.notes);
  final form = GlobalKey<FormState>();
  return showDialog<Player>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(existing == null ? 'Add player' : 'Edit player'),
      content: SizedBox(
        width: 460,
        child: Form(
          key: form,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, spacing: 16, children: [
              TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Full name *'),
                  validator: (v) => (v ?? '').trim().length < 2 ? 'Enter the player\'s name' : null),
              TextFormField(controller: no, decoration: const InputDecoration(labelText: 'Player / club number')),
              TextFormField(controller: idDoc, decoration: const InputDecoration(labelText: 'ID document (type and number)',
                  helperText: 'ID on file lets currency reports be completed without interrupting play (Ch5 p.72)')),
              TextFormField(controller: addr, decoration: const InputDecoration(labelText: 'Permanent address')),
              TextFormField(controller: notes, decoration: const InputDecoration(labelText: 'Notes'), maxLines: 2),
            ]),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            if (!form.currentState!.validate()) return;
            final r = await ref.read(playersNotifierProvider.notifier).savePlayer(
              existing: existing,
              name: name.text,
              playerNo: no.text,
              idDocument: idDoc.text,
              address: addr.text,
              notes: notes.text,
            );
            if (!ctx.mounted) return;
            r.fold((f) => showMsg(ctx, f.displayMessage, error: true), (p) => Navigator.pop(ctx, p));
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

class PlayerDetailPage extends ConsumerWidget {
  final String playerId;
  const PlayerDetailPage({super.key, required this.playerId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = ref.watch(playerByIdProvider(playerId));
    final user = ref.watch(currentUserValueProvider);
    final settings = ref.watch(settingsProvider);
    if (p == null) {
      return const Scaffold(body: Center(child: Text('Player not found.')));
    }
    final ratings = ref.watch(ratingsForPlayerProvider(playerId));
    final s = TripSummary.of(ratings);
    final comp = Comps.allowance(theo: s.theo, actualLoss: s.actualCasinoWin, policy: settings.comps);
    final markers = ref.watch(markersForPlayerProvider(playerId));
    final outstanding = markers.fold<double>(0, (a, m) => a + m.balance);
    final lines = (ref.watch(creditAppsProvider).value ?? const <CreditApplication>[])
        .where((a) => a.playerId == playerId && a.status == CreditStatus.approved)
        .toList();
    return Scaffold(
      body: PageBody(children: [
        Row(children: [
          Expanded(child: Text(p.name, style: Theme.of(context).textTheme.headlineSmall)),
          if (user?.can(Perm.managePlayers) == true)
            IconButton(tooltip: 'Edit', onPressed: () => showPlayerForm(context, ref, existing: p), icon: const Icon(Icons.edit_outlined)),
        ]),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text([
            if (p.playerNo.isNotEmpty) 'Player #${p.playerNo}',
            p.hasIdOnFile ? 'ID & address on file' : 'ID or address missing — needed for currency reports',
          ].join(' · ')),
        ),
        SectionCard(
          title: 'Player value (all rated play)',
          subtitle: 'Comps are based on theoretical win, not actual loss (Ch12 p.220)',
          trailing: user?.can(Perm.ratePlayers) == true
              ? FilledButton.icon(onPressed: () => context.go(Routes.ratePlayer(p.id)), icon: const Icon(Icons.add_chart), label: const Text('Rate play'))
              : null,
          children: [
            MetricGrid([
              Metric('Theoretical win', money0(s.theo)),
              Metric('Actual result (casino)', money0(s.actualCasinoWin), color: s.actualCasinoWin < 0 ? Brand.danger : null),
              Metric('Weighted avg bet', money0(s.weightedAvgBet), note: 'Time-weighted (Ch19 p.364)'),
              Metric('Hours rated', numf(s.hours)),
              Metric('Comp allowance', money0(comp.allowance), note: comp.basis),
              Metric('Expected range ±2σ', s.sessions == 0 ? '—' : '${money0(s.theo - 2 * s.sd)} … ${money0(s.theo + 2 * s.sd)}'),
            ]),
            const SizedBox(height: 12),
            const Refs([Rating.ref, Comps.ref, Stats.ref]),
          ],
        ),
        SectionCard(title: 'Credit', children: [
          if (lines.isEmpty) const Text('No approved credit line.'),
          for (final a in lines)
            Text('${a.lineType == LineType.permanent ? 'Permanent' : 'Temporary (TTO)'} line ${money0(a.amount)} — approved ${date(a.decidedAt ?? a.createdAt)}'),
          const SizedBox(height: 6),
          Text('Outstanding markers: ${money0(outstanding)} (${markers.where((m) => m.balance > 0).length} open)'),
        ]),
        SectionCard(title: 'Rated sessions', children: [
          if (ratings.isEmpty) const EmptyState('No sessions rated yet.', icon: Icons.casino_outlined),
          if (ratings.isNotEmpty)
            SimpleTable(columns: const [
              'Date', 'Game', 'Avg bet', 'Time', 'Players', 'Type', 'Theo', 'Actual', 'Rated by'
            ], rows: [
              for (final r in ratings)
                [
                  Text(dateTime(r.at)), Text(r.gameName), Text(money0(r.averageBet)), Text('${r.minutes.toStringAsFixed(0)} min'),
                  Text('${r.players}'), Text(r.type.label), Text(money(r.theo)), Text(money0(r.actualCasinoWin)), Text(r.ratedBy),
                ]
            ]),
        ]),
        if (p.notes.isNotEmpty) SectionCard(title: 'Notes', children: [Text(p.notes)]),
      ]),
    );
  }
}

class RateSessionPage extends ConsumerStatefulWidget {
  final String playerId;
  const RateSessionPage({super.key, required this.playerId});
  @override
  ConsumerState<RateSessionPage> createState() => _RateSessionPageState();
}

class _RateSessionPageState extends ConsumerState<RateSessionPage> {
  final form = GlobalKey<FormState>();
  String gameId = 'blackjack';
  PlayerType type = PlayerType.average;
  final bet = TextEditingController();
  final minutes = TextEditingController();
  final players = TextEditingController(text: '3');
  final actual = TextEditingController(text: '0');
  final table = TextEditingController();
  bool saving = false;

  RatingResult? _calc(AppSettings s) {
    final b = parseNum(bet.text), m = parseNum(minutes.text), n = parseNum(players.text);
    if (b == null || m == null || n == null || b <= 0 || m <= 0 || n < 1) return null;
    final g = s.game(gameId);
    final t = g.multipliers[type] == null ? PlayerType.average : type;
    return Rating.rate(RatingInput(game: g, averageBet: b, minutes: m, players: n.round(), type: t));
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(settingsProvider);
    final p = ref.watch(playerByIdProvider(widget.playerId));
    final user = ref.watch(currentUserValueProvider);
    if (user == null || !user.can(Perm.ratePlayers)) {
      return Scaffold(appBar: AppBar(), body: const PageBody(children: [NoAccess('rating players')]));
    }
    final g = s.game(gameId);
    final r = _calc(s);
    return Scaffold(
      appBar: AppBar(title: Text('Rate play — ${p?.name ?? ''}')),
      body: PageBody(maxWidth: 900, children: [
        Form(
          key: form,
          onChanged: () => setState(() {}),
          child: SectionCard(title: 'Rating card', subtitle: 'Fig 12.1 — record the INITIAL bet only, not doubles or splits (p.225)', children: [
            FieldGrid(children: [
              DropdownButtonFormField<String>(
                  isExpanded: true,
                initialValue: gameId,
                decoration: const InputDecoration(labelText: 'Game'),
                items: s.games.map((g) => DropdownMenuItem(value: g.id, child: Text(g.name))).toList(),
                onChanged: (v) => setState(() {
                  gameId = v!;
                  if (s.game(gameId).multipliers[type] == null) type = PlayerType.average;
                }),
              ),
              TextFormField(controller: table, decoration: const InputDecoration(labelText: 'Table')),
              NumField(label: 'Average initial bet', controller: bet, prefix: '\$ ', min: 1),
              NumField(label: 'Time played', controller: minutes, suffix: 'min', min: 1, max: 1440, integer: true),
              NumField(label: 'Players at table (avg)', controller: players, min: 1, max: 14, integer: true,
                  helper: gameId == 'craps' ? 'Craps: count players on the busiest end (p.232)' : 'Sets game speed (Table 13.1)'),
              DropdownButtonFormField<PlayerType>(
                  isExpanded: true,
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Player type', helperText: 'When in doubt choose the most conservative (p.229)'),
                items: PlayerType.values
                    .where((t) => g.multipliers[t] != null)
                    .map((t) => DropdownMenuItem(value: t, child: Text('${t.label} (×${g.multipliers[t]})')))
                    .toList(),
                onChanged: (v) => setState(() => type = v!),
              ),
              NumField(label: 'Actual result for casino', controller: actual, prefix: '\$ ', min: -100000000,
                  helper: 'Positive if the player lost', required: false),
            ]),
          ]),
        ),
        SectionCard(title: 'Theoretical win', children: [
          if (r == null) const Text('Enter bet, time and players to see the rating.'),
          if (r != null) ...[
            MetricGrid([
              Metric('Decisions / hour', numf(r.decisionsPerHour), note: g.decisionsFromBook ? 'Book (Table 13.1)' : 'App default'),
              Metric('House advantage used', pct(r.effectiveAdvantage, 3), note: '${pct(g.houseAdvantage, 3)} × ${g.multipliers[type] ?? 1}'),
              Metric('Total wagered', money0(r.totalWagered)),
              Metric('Theoretical win', money(r.theoreticalWin)),
              Metric('Expected range ±1σ', '${money0(r.range(1).low)} … ${money0(r.range(1).high)}'),
              Metric('Chance casino loses', pct(Rating.probabilityCasinoLoses(r), 1)),
            ]),
            const SizedBox(height: 8),
            Text('Theo = avg bet × hours × decisions/hr × house advantage × player-type multiplier. Source: ${g.source}.',
                style: Theme.of(context).textTheme.bodySmall),
          ],
          const SizedBox(height: 8),
          const Refs([Rating.ref, RatingDefaults.refSpeed, Stats.ref]),
        ]),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.icon(
            onPressed: saving
                ? null
                : () async {
                    if (!form.currentState!.validate()) return;
                    final res = _calc(s);
                    if (res == null) return;
                    setState(() => saving = true);
                    final out = await ref.read(playersNotifierProvider.notifier).rateSession(
                      playerId: widget.playerId,
                      game: g,
                      result: res,
                      averageBet: parseNum(bet.text)!,
                      minutes: parseNum(minutes.text)!,
                      players: parseNum(players.text)!.round(),
                      type: type,
                      table: table.text,
                      actualCasinoWin: parseNum(actual.text) ?? 0,
                    );
                    if (!context.mounted) return;
                    setState(() => saving = false);
                    out.fold((f) => showMsg(context, f.displayMessage, error: true), (rec) {
                      showMsg(context, 'Rating saved — theo ${money(rec.theo)}');
                      context.go(Routes.player(widget.playerId));
                    });
                  },
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save rating'),
          ),
        ),
      ]),
    );
  }
}
