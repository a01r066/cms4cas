import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/auth/roles.dart';
import '../../../core/auth/session.dart';
import '../../../core/data/repository.dart';
import '../../../core/util/fmt.dart';
import '../../../core/widgets/widgets.dart';
import '../../players/data/models.dart';
import '../data/credit_models.dart';

class CreditPage extends ConsumerWidget {
  const CreditPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TabBar(tabs: [Tab(text: 'Applications'), Tab(text: 'Markers & collections')]),
        body: const TabBarView(children: [_ApplicationsTab(), _MarkersTab()]),
      ),
    );
  }
}

class _ApplicationsTab extends ConsumerWidget {
  const _ApplicationsTab();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final apps = ref.watch(creditAppsProvider).value ?? const <CreditApplication>[];
    final players = ref.watch(playersProvider).value ?? const <Player>[];
    String name(String id) => players.where((p) => p.id == id).map((p) => p.name).firstOrNull ?? 'Unknown player';
    return PageBody(children: [
      Row(children: [
        Expanded(child: Text('Credit applications', style: Theme.of(context).textTheme.titleLarge)),
        if (user?.can(Perm.creditApply) == true)
          FilledButton.icon(onPressed: () => _newApplication(context, ref), icon: const Icon(Icons.add), label: const Text('New application')),
      ]),
      const SizedBox(height: 8),
      const Refs([Credit.refAuthorization, Credit.refPolicy]),
      const SizedBox(height: 12),
      if (apps.isEmpty) const EmptyState('No credit applications yet.', icon: Icons.credit_card),
      if (apps.isNotEmpty)
        Card(
          child: SimpleTable(
            columns: const ['Created', 'Player', 'Line', 'Amount', 'Assessment', 'Signatures', 'Status'],
            rows: [
              for (final a in apps)
                [
                  Text(date(a.createdAt)), Text(name(a.playerId)),
                  Text(a.lineType == LineType.permanent ? 'Permanent' : 'Temporary'), Text(money0(a.amount)),
                  Text(_outcomeLabel(a.outcome)), Text('${a.signatures.length} · ${a.signatureCheck.satisfied ? 'complete' : 'incomplete'}'),
                  _StatusChip(a.status),
                ]
            ],
            onTap: [for (final a in apps) () => context.go('/credit/${a.id}')],
          ),
        ),
    ]);
  }

  Future<void> _newApplication(BuildContext context, WidgetRef ref) async {
    final players = ref.read(playersProvider).value ?? const <Player>[];
    if (players.isEmpty) {
      showMsg(context, 'Add the player first (Players page).', error: true);
      return;
    }
    String? playerId;
    var type = LineType.permanent;
    final amount = TextEditingController();
    final disposition = TextEditingController(text: 'Statement to residence — pay within 30 days of last marker');
    final form = GlobalKey<FormState>();
    final created = await showDialog<CreditApplication>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, set) => AlertDialog(
          title: const Text('New credit application'),
          content: SizedBox(
            width: 460,
            child: Form(
              key: form,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Player *'),
                  items: players.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                  onChanged: (v) => playerId = v,
                  validator: (v) => v == null ? 'Choose a player' : null,
                ),
                DropdownButtonFormField<LineType>(
                  isExpanded: true,
                  initialValue: type,
                  decoration: const InputDecoration(labelText: 'Line type'),
                  items: const [
                    DropdownMenuItem(value: LineType.permanent, child: Text('Permanent line')),
                    DropdownMenuItem(value: LineType.temporary, child: Text('Temporary / this trip only (TTO)')),
                  ],
                  onChanged: (v) => set(() => type = v!),
                ),
                NumField(label: 'Amount requested', controller: amount, prefix: '\$ ', min: 100),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: disposition.text,
                  decoration: const InputDecoration(labelText: 'Disposition (how the player will pay) — p.97'),
                  items: const [
                    'Check on departure',
                    'Pay an outside (branch) office within 30 days',
                    'Statement to residence — pay within 30 days of last marker',
                    'Send no statement — pay within 30 days',
                  ].map((d) => DropdownMenuItem(value: d, child: Text(d, overflow: TextOverflow.ellipsis))).toList(),
                  onChanged: (v) => disposition.text = v!,
                ),
              ]),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            FilledButton(
              onPressed: () async {
                if (!form.currentState!.validate()) return;
                final id = Repository.newId();
                final a = CreditApplication(
                  id: id, playerId: playerId!, createdBy: ref.read(currentUserProvider)?.name ?? '', lineType: type,
                  amount: parseNum(amount.text)!, status: CreditStatus.draft, createdAt: DateTime.now(), disposition: disposition.text,
                );
                final r = await ref.read(creditRepoProvider).save(id, a);
                if (!ctx.mounted) return;
                r.fold((f) => showMsg(ctx, f.displayMessage, error: true), (_) => Navigator.pop(ctx, a));
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
    if (created != null && context.mounted) context.go('/credit/${created.id}');
  }
}

String _outcomeLabel(String? o) => switch (o) {
      'readyForDecision' => 'Ready for decision',
      'proceedWithCaution' => 'Proceed with caution',
      'referToCreditManager' => 'Refer to credit manager',
      'doNotIssue' => 'Do not issue',
      'incomplete' => 'Incomplete',
      _ => 'Not assessed',
    };

class _StatusChip extends StatelessWidget {
  final CreditStatus s;
  const _StatusChip(this.s);
  @override
  Widget build(BuildContext context) {
    final c = switch (s) {
      CreditStatus.approved => Colors.green.shade700,
      CreditStatus.declined => Colors.red.shade700,
      CreditStatus.pendingApproval => Colors.orange.shade800,
      CreditStatus.draft => Colors.grey.shade700,
    };
    return Text(s.label, style: TextStyle(color: c, fontWeight: FontWeight.w600));
  }
}

/// Application detail: Fig 6.4 walkthrough → assessment → Table 6.2 signatures → decision.
class CreditApplicationPage extends ConsumerStatefulWidget {
  final String appId;
  const CreditApplicationPage({super.key, required this.appId});
  @override
  ConsumerState<CreditApplicationPage> createState() => _CreditApplicationPageState();
}

class _CreditApplicationPageState extends ConsumerState<CreditApplicationPage> {
  Map<String, dynamic>? answers;
  final level = ValueNotifier<String>('Low');
  final digits = TextEditingController(text: '5');

  static const _questions = <(String, String, String?)>[
    ('applicationComplete', 'Application complete and signed by the customer', null),
    ('applicationLegible', 'Application legible', null),
    ('idCopied', 'Identification / passport photocopied', null),
    ('gamingReportObtained', 'Gaming report obtained from Central Credit', null),
    ('fourIn14', 'Customer reported as "4 in 14" (applied at ≥4 casinos in 2 weeks)', null),
    ('consumerReportObtained', 'Consumer credit report obtained', null),
    ('consumerReportClear', 'Consumer credit report is clear', 'consumerReportObtained'),
    ('creditElsewhere', 'Customer has casino credit elsewhere', null),
    ('inTransitRequested', 'In-transit report requested', 'creditElsewhere'),
    ('customerOwes', 'Customer owes other casinos', 'creditElsewhere'),
    ('afterBankingHours', 'It is after banking hours', 'creditElsewhere'),
    ('bankCheckObtained', 'Bank check obtained', null),
    ('canSignAlone', 'Customer can sign on the account alone', null),
    ('accountOpen6Months', 'Account open at least 6 months (1 year preferred, p.92)', null),
    ('averageBalanceSupports', 'Average balance supports the request', null),
    ('hasDerogs', 'Customer has derogatory information at Central', 'creditElsewhere'),
    ('derogsPaid', 'Derogs are paid (not owed)', 'hasDerogs'),
    ('bankInfoAtCentral', 'Bank info available through Central', 'creditElsewhere'),
    ('currentLimitEqualsRequest', 'Current limits elsewhere equal the request', 'bankInfoAtCentral'),
  ];

  @override
  Widget build(BuildContext context) {
    final apps = ref.watch(creditAppsProvider).value ?? const <CreditApplication>[];
    final a = apps.where((x) => x.id == widget.appId).firstOrNull;
    final user = ref.watch(currentUserProvider);
    if (a == null) return const Scaffold(body: Center(child: Text('Application not found.')));
    final p = ref.watch(playerByIdProvider(a.playerId));
    answers ??= Map<String, dynamic>.from(a.answers);
    bool v(String k) => (answers![k] ?? false) as bool;
    final editable = a.status == CreditStatus.draft && user?.can(Perm.creditAssess) == true;
    final sig = a.signatureCheck;
    final range = Credit.bankRatingRange(level.value, (parseNum(digits.text) ?? 5).round().clamp(1, 9));

    return Scaffold(
      body: PageBody(maxWidth: 950, children: [
        Text('Credit application — ${p?.name ?? ''}', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text('${a.lineType == LineType.permanent ? 'Permanent' : 'Temporary (TTO)'} line · ${money0(a.amount)} · ${a.disposition}'),
        const SizedBox(height: 12),
        if (a.lineType == LineType.temporary)
          Callout('Temporary increases are normally limited to 20–25% of the established line and should be granted between trips or at the start of a trip, not during heavy losses (p.101–102).'),
        SectionCard(
          title: '1 · Authorization process',
          subtitle: 'Fig 6.4 — answer each check; the flow decides the next step',
          children: [
            for (final q in _questions)
              if (q.$3 == null || v(q.$3!))
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(q.$2),
                  value: v(q.$1),
                  onChanged: editable ? (x) => setState(() => answers![q.$1] = x) : null,
                ),
            const SizedBox(height: 8),
            if (editable)
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  icon: const Icon(Icons.rule),
                  label: const Text('Run assessment'),
                  onPressed: () async {
                    final r = CreditAuthorizationFlow.evaluate(_answersFor(a.amount, answers!));
                    final upd = a.copyWith(answers: answers, outcome: r.outcome.name, referrals: r.referrals);
                    final res = await ref.read(creditRepoProvider).save(a.id, upd);
                    if (context.mounted) res.fold((f) => showMsg(context, f.displayMessage, error: true), (_) => showMsg(context, 'Assessment: ${_outcomeLabel(r.outcome.name)}'));
                  },
                ),
              ),
            if (a.outcome != null) ...[
              const Divider(),
              _outcomeCallout(a),
              for (final r in a.referrals) Text('• $r'),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text('Path through Fig 6.4'),
                children: [
                  for (final s in CreditAuthorizationFlow.evaluate(_answersFor(a.amount, a.answers)).path)
                    ListTile(dense: true, leading: CircleAvatar(radius: 12, child: Text('${s.number}', style: const TextStyle(fontSize: 11))),
                        title: Text(s.question), subtitle: s.note == null ? null : Text(s.note!), trailing: Text(s.answer)),
                ],
              ),
            ],
          ],
        ),
        SectionCard(title: 'Bank balance code decoder', subtitle: 'Banks report averages as Low/Med/High + number of digits (p.92–93)', children: [
          FieldGrid(children: [
            DropdownButtonFormField<String>(
                  isExpanded: true,
              initialValue: level.value,
              decoration: const InputDecoration(labelText: 'Level'),
              items: const ['Low', 'Med', 'High'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (x) => setState(() => level.value = x!),
            ),
            NumField(label: 'Digits', controller: digits, integer: true, min: 1, max: 9, onChanged: (_) => setState(() {})),
            Metric('Average balance range', '${money0(range.$1)} – ${money0(range.$2)}'),
          ]),
        ]),
        SectionCard(
          title: '2 · Signatures',
          subtitle: sig.rule,
          trailing: const BookRefChip(Credit.refPolicy),
          children: [
            if (a.signatures.isEmpty) const Text('No signatures yet.'),
            for (final s in a.signatures) ListTile(dense: true, leading: const Icon(Icons.draw_outlined), title: Text('${s.userName} — ${s.role.label}'), subtitle: Text(dateTime(s.at))),
            const SizedBox(height: 8),
            sig.satisfied ? Callout.good('Signature requirement met.') : Callout.warn('Still needed: ${sig.missing}'),
            Wrap(spacing: 8, runSpacing: 8, children: [
              if (a.status == CreditStatus.draft && a.outcome != null && user?.can(Perm.creditAssess) == true)
                OutlinedButton.icon(
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('Submit for signatures'),
                  onPressed: a.outcome == 'doNotIssue' || a.outcome == 'incomplete'
                      ? null
                      : () => _save(a.copyWith(status: CreditStatus.pendingApproval), 'Submitted for signatures'),
                ),
              if (a.status == CreditStatus.pendingApproval && user != null && user.canSignCredit && !a.signatures.any((s) => s.userId == user.id))
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.draw),
                  label: Text('Sign as ${user.creditRole!.label}'),
                  onPressed: () => _save(
                      a.copyWith(signatures: [...a.signatures, Signature(user.id, user.name, user.creditRole!, DateTime.now())]), 'Signed'),
                ),
              if (a.status == CreditStatus.pendingApproval && user != null && user.can(Perm.creditApprove))
                FilledButton.icon(
                  icon: const Icon(Icons.verified_outlined),
                  label: const Text('Approve line'),
                  onPressed: !_canApprove(a) ? null : () => _save(a.copyWith(status: CreditStatus.approved, decidedAt: DateTime.now()), 'Line approved'),
                ),
              if ((a.status == CreditStatus.pendingApproval || a.status == CreditStatus.draft) && user?.can(Perm.creditApprove) == true)
                TextButton.icon(
                  icon: const Icon(Icons.block),
                  label: const Text('Decline'),
                  onPressed: () async {
                    final reason = await _askText(context, 'Reason for declining');
                    if (reason != null) await _save(a.copyWith(status: CreditStatus.declined, decidedAt: DateTime.now(), declineReason: reason), 'Declined');
                  },
                ),
            ]),
            if (a.status == CreditStatus.pendingApproval && a.outcome == 'referToCreditManager' && !a.signatures.any((s) => s.role == CreditRole.creditManager))
              const Padding(padding: EdgeInsets.only(top: 8), child: Text('Referred: a Credit Manager signature is required before approval.')),
          ],
        ),
        SectionCard(title: 'Decision', children: [
          _StatusChip(a.status),
          if (a.declineReason.isNotEmpty) Text('Reason: ${a.declineReason}'),
          if (a.decidedAt != null) Text('Decided ${dateTime(a.decidedAt!)}'),
        ]),
      ]),
    );
  }

  bool _canApprove(CreditApplication a) {
    if (!a.signatureCheck.satisfied) return false;
    if (a.outcome == 'doNotIssue' || a.outcome == 'incomplete' || a.outcome == null) return false;
    if (a.outcome == 'referToCreditManager' && !a.signatures.any((s) => s.role == CreditRole.creditManager)) return false;
    return true;
  }

  Widget _outcomeCallout(CreditApplication a) => switch (a.outcome) {
        'readyForDecision' => Callout.good('All checks passed — ready for a credit decision.'),
        'proceedWithCaution' => Callout.warn('No bank information through Central — proceed with caution.'),
        'referToCreditManager' => Callout.warn('Refer to the credit manager:'),
        'doNotIssue' => Callout.bad('Do not issue credit.'),
        _ => Callout.warn('Application incomplete:'),
      };

  Future<void> _save(CreditApplication a, String msg) async {
    final r = await ref.read(creditRepoProvider).save(a.id, a);
    if (mounted) r.fold((f) => showMsg(context, f.displayMessage, error: true), (_) => showMsg(context, msg));
  }
}

CreditCheckAnswers _answersFor(double amount, Map<String, dynamic> m) {
  bool b(String k) => (m[k] ?? false) as bool;
  return CreditCheckAnswers(
    applicationComplete: b('applicationComplete'), applicationLegible: b('applicationLegible'), amountRequested: amount,
    idCopied: b('idCopied'), gamingReportObtained: b('gamingReportObtained'), fourIn14: b('fourIn14'),
    consumerReportObtained: b('consumerReportObtained'), consumerReportClear: b('consumerReportClear'),
    creditElsewhere: b('creditElsewhere'), inTransitRequested: b('inTransitRequested'), customerOwes: b('customerOwes'),
    afterBankingHours: b('afterBankingHours'), bankCheckObtained: b('bankCheckObtained'), canSignAlone: b('canSignAlone'),
    accountOpen6Months: b('accountOpen6Months'), averageBalanceSupports: b('averageBalanceSupports'), hasDerogs: b('hasDerogs'),
    derogsPaid: b('derogsPaid'), bankInfoAtCentral: b('bankInfoAtCentral'), currentLimitEqualsRequest: b('currentLimitEqualsRequest'),
  );
}

Future<String?> _askText(BuildContext context, String label) {
  final c = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(label),
      content: TextField(controller: c, autofocus: true, maxLines: 3),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(onPressed: () => c.text.trim().isEmpty ? null : Navigator.pop(ctx, c.text.trim()), child: const Text('OK')),
      ],
    ),
  );
}

class _MarkersTab extends ConsumerWidget {
  const _MarkersTab();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final markers = ref.watch(markersProvider).value ?? const <Marker>[];
    final players = ref.watch(playersProvider).value ?? const <Player>[];
    String name(String id) => players.where((p) => p.id == id).map((p) => p.name).firstOrNull ?? 'Unknown';
    final open = markers.where((m) => m.balance > 0).toList();
    final outstanding = open.fold<double>(0, (a, m) => a + m.balance);
    int bucket(int d) => d <= 30 ? 0 : d <= 60 ? 1 : d <= 90 ? 2 : 3;
    final aging = List<double>.filled(4, 0);
    for (final m in open) {
      aging[bucket(m.ageDays)] += m.balance;
    }
    return PageBody(children: [
      Row(children: [
        Expanded(child: Text('Markers & collections', style: Theme.of(context).textTheme.titleLarge)),
        if (user?.can(Perm.markers) == true)
          FilledButton.icon(onPressed: () => _issueMarker(context, ref), icon: const Icon(Icons.receipt_long), label: const Text('Issue marker')),
      ]),
      const SizedBox(height: 12),
      MetricGrid([
        Metric('Outstanding', money0(outstanding), note: '${open.length} open markers'),
        Metric('0–30 days', money0(aging[0])),
        Metric('31–60 days', money0(aging[1])),
        Metric('61–90 days', money0(aging[2])),
        Metric('Over 90 days', money0(aging[3]), color: aging[3] > 0 ? Colors.red.shade700 : null),
      ]),
      const SizedBox(height: 8),
      const Callout('Collections: send a statement within one week of departure unless "no statement" was requested; phone when the disposition date passes; outside agencies charge 25–50% (p.104).'),
      const SizedBox(height: 8),
      if (markers.isEmpty) const EmptyState('No markers issued.', icon: Icons.receipt_long),
      if (markers.isNotEmpty)
        Card(
          child: SimpleTable(
            columns: const ['Issued', '#', 'Player', 'Table', 'Amount', 'Paid', 'Balance', 'Age', 'Status'],
            rows: [
              for (final m in markers)
                [
                  Text(date(m.issuedAt)), Text(m.number), Text(name(m.playerId)), Text(m.table), Text(money0(m.amount)),
                  Text(money0(m.paid)), Text(money0(m.balance)), Text('${m.ageDays} d'), Text(m.status.label),
                ]
            ],
            onTap: [for (final m in markers) () => _markerActions(context, ref, m, name(m.playerId))],
          ),
        ),
      const SizedBox(height: 8),
      const Refs([BookRef(9, '169–172', 'Markers, marker vs name credit system'), BookRef(6, '103–105', 'Collections, settlements and write-offs')]),
    ]);
  }

  Future<void> _issueMarker(BuildContext context, WidgetRef ref) async {
    final players = ref.read(playersProvider).value ?? const <Player>[];
    final apps = ref.read(creditAppsProvider).value ?? const <CreditApplication>[];
    final markers = ref.read(markersProvider).value ?? const <Marker>[];
    final withLines = players.where((p) => availableCredit(apps, markers, p.id).line > 0).toList();
    if (withLines.isEmpty) {
      showMsg(context, 'No player has an approved credit line yet.', error: true);
      return;
    }
    String? playerId;
    final amount = TextEditingController();
    final table = TextEditingController();
    final number = TextEditingController();
    final form = GlobalKey<FormState>();
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (ctx, set) {
        final av = playerId == null ? null : availableCredit(apps, markers, playerId!);
        return AlertDialog(
          title: const Text('Issue marker (rim credit)'),
          content: SizedBox(
            width: 440,
            child: Form(
              key: form,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Player *'),
                  items: withLines.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                  onChanged: (x) => set(() => playerId = x),
                  validator: (x) => x == null ? 'Choose a player' : null,
                ),
                if (av != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('Line ${money0(av.line)} · outstanding ${money0(av.outstanding)} · available ${money0(av.available)}'),
                  ),
                TextFormField(controller: number, decoration: const InputDecoration(labelText: 'Marker number *'),
                    validator: (x) => (x ?? '').trim().isEmpty ? 'Required' : null),
                TextFormField(controller: table, decoration: const InputDecoration(labelText: 'Table / pit *'),
                    validator: (x) => (x ?? '').trim().isEmpty ? 'Required' : null),
                TextFormField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount *', prefixText: '\$ '),
                  validator: (x) {
                    final n = parseNum(x);
                    if (n == null || n <= 0) return 'Enter an amount';
                    if (av != null && n > av.available) return 'Exceeds available credit (${money0(av.available)})';
                    return null;
                  },
                ),
              ]),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            FilledButton(
              onPressed: () async {
                if (!form.currentState!.validate()) return;
                final id = Repository.newId();
                final m = Marker(
                  id: id, playerId: playerId!, number: number.text.trim(), table: table.text.trim(),
                  issuedBy: ref.read(currentUserProvider)?.name ?? '', amount: parseNum(amount.text)!, issuedAt: DateTime.now(),
                );
                final r = await ref.read(markersRepoProvider).save(id, m);
                if (!ctx.mounted) return;
                r.fold((f) => showMsg(ctx, f.displayMessage, error: true), (_) => Navigator.pop(ctx));
              },
              child: const Text('Issue'),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _markerActions(BuildContext context, WidgetRef ref, Marker m, String playerName) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    final amount = TextEditingController(text: m.balance.toStringAsFixed(2));
    var method = 'Check';
    final reason = TextEditingController(text: m.writeOffReason);
    final note = TextEditingController(text: m.collectionNote);
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (ctx, set) {
        Future<void> save(Marker x, String msg) async {
          final r = await ref.read(markersRepoProvider).save(x.id, x);
          if (!ctx.mounted) return;
          r.fold((f) => showMsg(ctx, f.displayMessage, error: true), (_) {
            showMsg(ctx, msg);
            Navigator.pop(ctx);
          });
        }

        final signers = m.writeOffSignatures.map((s) => s.role).toList();
        return AlertDialog(
          title: Text('Marker ${m.number} — $playerName'),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text('Amount ${money(m.amount)} · paid ${money(m.paid)} · balance ${money(m.balance)} · ${m.status.label}'),
                for (final p in m.payments) Text('  ${date(p.at)}  ${money(p.amount)}  ${p.method}  (${p.recordedBy})', style: Theme.of(ctx).textTheme.bodySmall),
                if (m.status == MarkerStatus.open && user.can(Perm.markers)) ...[
                  const Divider(),
                  const Text('Record payment', style: TextStyle(fontWeight: FontWeight.w600)),
                  TextField(controller: amount, decoration: const InputDecoration(labelText: 'Amount', prefixText: '\$ '), keyboardType: TextInputType.number),
                  DropdownButtonFormField<String>(
                  isExpanded: true,
                    initialValue: method,
                    decoration: const InputDecoration(labelText: 'Method'),
                    items: const ['Cash', 'Cheques (in pit)', 'Check', 'Wire'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (x) => set(() => method = x!),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () {
                      final a = parseNum(amount.text);
                      if (a == null || a <= 0 || a > m.balance + 0.001) {
                        showMsg(ctx, 'Enter an amount between \$0 and the balance.', error: true);
                        return;
                      }
                      final pays = [...m.payments, MarkerPayment(a, method, user.name, DateTime.now())];
                      final paidAll = pays.fold<double>(0, (s, p) => s + p.amount) >= m.amount - 0.001;
                      save(m.copyWith(payments: pays, status: paidAll ? MarkerStatus.paid : MarkerStatus.open), 'Payment recorded');
                    },
                    child: const Text('Record payment'),
                  ),
                  const Divider(),
                  const Text('Collection note', style: TextStyle(fontWeight: FontWeight.w600)),
                  TextField(controller: note, maxLines: 2, decoration: const InputDecoration(hintText: 'Statement sent, phone call, promised date…')),
                  TextButton(onPressed: () => save(m.copyWith(collectionNote: note.text.trim()), 'Note saved'), child: const Text('Save note')),
                  const Divider(),
                  const Text('Settlement / write-off of the balance', style: TextStyle(fontWeight: FontWeight.w600)),
                  const Text('Needs signatures of two of: President/GM, VP Finance, Credit Manager, Director of Cage (p.105). Tax may be due on unpaid credit without signature, address, history check or collection evidence (p.39).'),
                  TextField(controller: reason, decoration: const InputDecoration(labelText: 'Reason (induce payment, dispute, retain patron…)')),
                  Text('Signed by: ${m.writeOffSignatures.isEmpty ? 'nobody yet' : m.writeOffSignatures.map((s) => '${s.userName} (${s.role.label})').join(', ')}'),
                  Wrap(spacing: 8, children: [
                    if (user.creditRole != null && !m.writeOffSignatures.any((s) => s.userId == user.id))
                      OutlinedButton(
                        onPressed: () => save(
                            m.copyWith(writeOffReason: reason.text.trim(), writeOffSignatures: [...m.writeOffSignatures, Signature(user.id, user.name, user.creditRole!, DateTime.now())]),
                            'Signed'),
                        child: Text('Sign as ${user.creditRole!.label}'),
                      ),
                    FilledButton.tonal(
                      onPressed: !Credit.writeOffApproved(signers) || reason.text.trim().isEmpty
                          ? null
                          : () => save(m.copyWith(status: m.paid > 0 ? MarkerStatus.settled : MarkerStatus.writtenOff, writeOffAmount: m.balance, writeOffReason: reason.text.trim()),
                              'Balance written off'),
                      child: const Text('Write off balance'),
                    ),
                  ]),
                ],
              ]),
            ),
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close'))],
        );
      }),
    );
  }
}
