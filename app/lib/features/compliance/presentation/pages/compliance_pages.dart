import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/typedefs/typedefs.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/util/fmt.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/domain/entities/app_role.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/compliance_entities.dart';
import '../providers/compliance_notifier.dart';
import '../providers/compliance_providers.dart';
import '../../../players/domain/entities/player.dart';
import '../../../players/presentation/providers/players_providers.dart';
import '../../../settings/presentation/providers/settings_providers.dart';

class CompliancePage extends StatelessWidget {
  const CompliancePage({super.key});
  @override
  Widget build(BuildContext context) => const DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: TabBar(isScrollable: true, tabAlignment: TabAlignment.start, tabs: [Tab(text: 'Cash log (MTL)'), Tab(text: 'Aggregation & CTR'), Tab(text: 'Barred patrons'), Tab(text: 'SAR cases')]),
          body: TabBarView(children: [_CashLog(), _Aggregation(), _Barred(), _Sar()]),
        ),
      );
}

class _CashLog extends ConsumerStatefulWidget {
  const _CashLog();
  @override
  ConsumerState<_CashLog> createState() => _CashLogState();
}

class _CashLogState extends ConsumerState<_CashLog> {
  final form = GlobalKey<FormState>();
  String? playerId;
  final unknown = TextEditingController();
  var type = CashTxType.chipPurchase;
  final amount = TextEditingController();
  final area = TextEditingController();
  bool sameVisit = false;
  String? visitId;
  String? prohibitedKind;
  final prohibitedAmt = TextEditingController();
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserValueProvider);
    final s = ref.watch(settingsProvider);
    final p = s.aml;
    final players = ref.watch(playersProvider).value ?? const <Player>[];
    final txs = ref.watch(cashTxProvider).value ?? const <CashTxRecord>[];
    final barred = ref.watch(barredProvider).value ?? const <BarredPatron>[];
    final today = Aml.gamingDay(DateTime.now(), p.gamingDayStartHour);
    final todays = txs.where((t) => Aml.gamingDay(t.at, p.gamingDayStartHour) == today).toList();
    final mtl = <CashTxRecord>[];
    for (final t in todays.reversed) {
      final earlier = todays.where((e) => e.at.isBefore(t.at)).map((e) => e.tx).toList();
      if (Aml.needsMtlEntry(t.tx, earlier, p)) mtl.add(t);
    }
    final canEnter = user?.can(Perm.cashTransactions) == true;
    final isBarred = playerId != null && barred.any((b) => b.active && b.playerId == playerId);
    return PageBody(children: [
      Text('Gaming day ${date(today)} (starts ${p.gamingDayStartHour.toString().padLeft(2, '0')}:00) · ${p.regime.label}', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      if (canEnter)
        Form(
          key: form,
          child: SectionCard(title: 'Record cash transaction', subtitle: 'Log every transaction over ${money0(p.mtlThreshold)}, and smaller same-type amounts that combine above it (p.63)', children: [
            FieldGrid(children: [
              DropdownButtonFormField<String?>(
                  isExpanded: true,
                initialValue: playerId,
                decoration: const InputDecoration(labelText: 'Patron (known)'),
                items: [const DropdownMenuItem<String?>(value: null, child: Text('Unknown — describe below')), ...players.map((x) => DropdownMenuItem<String?>(value: x.id, child: Text(x.name)))],
                onChanged: (v) => setState(() => playerId = v),
              ),
              if (playerId == null)
                TextFormField(controller: unknown, decoration: const InputDecoration(labelText: 'Description of unknown patron *'),
                    validator: (v) => playerId == null && (v ?? '').trim().isEmpty ? 'Describe the patron' : null),
              DropdownButtonFormField<CashTxType>(
                  isExpanded: true,
                initialValue: type,
                
                decoration: const InputDecoration(labelText: 'Transaction type'),
                items: CashTxType.values.map((t) => DropdownMenuItem(value: t, child: Text('${t.direction == CashDirection.cashIn ? 'IN' : 'OUT'} · ${t.label}', overflow: TextOverflow.ellipsis))).toList(),
                onChanged: (v) => setState(() => type = v!),
              ),
              NumField(label: 'Cash amount', controller: amount, prefix: '\$ ', min: 1),
              TextFormField(controller: area, decoration: const InputDecoration(labelText: 'Area / table *', hintText: 'e.g. BJ-12, Cage'),
                  validator: (v) => (v ?? '').trim().isEmpty ? 'Required' : null),
            ]),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Same continuous visit at this location as the previous entry'),
              subtitle: const Text('Single-visit rule: all same-direction cash during one uninterrupted appearance is aggregated (p.71)'),
              value: sameVisit,
              onChanged: (v) => setState(() => sameVisit = v),
            ),
            if (isBarred) Callout.bad('This patron is on the barred list — no gaming transactions until the required information is provided (p.69).'),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Record'),
                onPressed: isBarred
                    ? null
                    : () async {
                        if (!form.currentState!.validate()) return;
                        final pl = players.where((x) => x.id == playerId).firstOrNull;
                        final r = await ref.read(complianceNotifierProvider.notifier).recordCashTx(
                              playerId: pl?.id,
                              playerName: pl?.name,
                              description: unknown.text,
                              area: area.text,
                              type: type,
                              amount: parseNum(amount.text)!,
                              visitId: sameVisit ? visitId : null,
                            );
                        if (!context.mounted) return;
                        r.fold((f) => showMsg(context, f.displayMessage, error: true), (rec) {
                          final key = rec.patronKey;
                          final id = rec.id;
                          setState(() {
                            visitId = rec.visitId;
                            amount.clear();
                          });
                          final all = [...todays.map((e) => e.tx), rec.tx];
                          final hit = Aml.aggregate(all, p).where((a) => a.patronKey == key && a.reportable && a.txIds.contains(id));
                          if (hit.isNotEmpty) {
                            showMsg(context, 'CTR required: ${hit.first.label} totals ${money0(hit.first.total)} — see Aggregation & CTR', error: true);
                          } else if (pl != null && !pl.hasIdOnFile) {
                            showMsg(context, 'Recorded. Note: no ID/address on file for ${pl.name}.');
                          } else {
                            showMsg(context, 'Recorded');
                          }
                        });
                      },
              ),
            ),
          ]),
        ),
      SectionCard(title: 'Multiple transaction log, today', subtitle: mtl.length == 1 ? '1 entry at or above the MTL threshold' : '${mtl.length} entries at or above the MTL threshold', children: [
        if (todays.isEmpty) const Text('No cash transactions recorded this gaming day.'),
        if (todays.isNotEmpty)
          SimpleTable(columns: const ['Time', 'Patron', 'Type', 'Amount', 'Area', 'MTL', 'By'], rows: [
            for (final t in todays)
              [Text(dateTime(t.at).substring(11)), Text(t.patronLabel), Text(t.type.label), Text(money0(t.amount)), Text(t.area), Text(mtl.contains(t) ? 'Yes' : ''), Text(t.recordedBy)]
          ]),
      ]),
      SectionCard(title: 'Prohibited transaction check', subtitle: 'Reg 6A (Nevada, 2003) — only applies under the Reg 6A regime', children: [
        FieldGrid(children: [
          DropdownButtonFormField<String>(
                  isExpanded: true,
            initialValue: prohibitedKind,
            decoration: const InputDecoration(labelText: 'Transaction'),
            items: const [
              DropdownMenuItem(value: 'cash_for_cash', child: Text('Cash-for-cash exchange')),
              DropdownMenuItem(value: 'casino_check_for_cash', child: Text('Casino check for cash')),
              DropdownMenuItem(value: 'winnings_to_third_party', child: Text('Winnings paid to a third party')),
            ],
            onChanged: (v) => setState(() => prohibitedKind = v),
          ),
          NumField(label: 'Amount', controller: prohibitedAmt, prefix: '\$ ', required: false, onChanged: (_) => setState(() {})),
          CheckboxListTile(contentPadding: EdgeInsets.zero, value: verified, onChanged: (v) => setState(() => verified = v!), title: const Text('Verified winnings')),
        ]),
        if (prohibitedKind != null)
          () {
            final reason = Aml.prohibited(profile: p, kind: prohibitedKind!, amount: parseNum(prohibitedAmt.text) ?? 0, verifiedWinnings: verified);
            return reason == null ? Callout.good('Allowed under the current profile.') : Callout.bad(reason);
          }(),
        const BookRefChip(BookRef(5, '63', 'Prohibited transactions')),
      ]),
    ]);
  }
}

class _Aggregation extends ConsumerWidget {
  const _Aggregation();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserValueProvider);
    final p = ref.watch(settingsProvider).aml;
    final txs = ref.watch(cashTxProvider).value ?? const <CashTxRecord>[];
    final ctrs = ref.watch(ctrProvider).value ?? const <CtrReport>[];
    final labels = {for (final t in txs) t.patronKey: t.patronLabel};
    final since = DateTime.now().subtract(const Duration(days: 7));
    final aggs = Aml.aggregate(txs.where((t) => t.at.isAfter(since)).map((t) => t.tx).toList(), p).where((a) => a.reportable || a.nearThreshold).toList();
    String key(Aggregate a) => '${a.patronKey}|${date(a.gamingDay)}|${a.direction.name}|${a.label}';
    final byKey = {for (final c in ctrs) '${c.patronKey}|${date(c.gamingDay)}|${c.direction}|${c.aggregateLabel}': c};
    return PageBody(children: [
      Text('Aggregation — last 7 gaming days', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 4),
      Text('${p.regime.label}: report when a total exceeds ${money0(p.ctrThreshold)}. Cash-in is never combined with cash-out.'),
      const SizedBox(height: 12),
      if (aggs.isEmpty) const EmptyState('No totals at or near the reporting threshold.', icon: Icons.verified_user_outlined),
      for (final a in aggs)
        Card(
          child: ListTile(
            leading: Icon(a.reportable ? Icons.report : Icons.trending_up, color: a.reportable ? Brand.danger : Brand.warning),
            title: Text('${labels[a.patronKey] ?? a.patronKey} — ${money0(a.total)}'),
            subtitle: Text('${date(a.gamingDay)} · ${a.direction == CashDirection.cashIn ? 'Cash in' : 'Cash out'} · ${a.label}'
                '${a.multiple ? ' · multiple transactions' : ''}${a.reportable ? '' : ' · near threshold'}'),
            trailing: !a.reportable
                ? null
                : byKey.containsKey(key(a))
                    ? Text(byKey[key(a)]!.status.label.toUpperCase())
                    : (user?.can(Perm.complianceReview) == true || user?.can(Perm.cashTransactions) == true)
                        ? FilledButton.tonal(
                            onPressed: () async {
                              final r = await ref.read(complianceNotifierProvider.notifier).startCtr(a, labels[a.patronKey] ?? a.patronKey);
                              if (context.mounted) r.fold((f) => showMsg(context, f.displayMessage, error: true), (_) => showMsg(context, 'CTR draft created'));
                            },
                            child: const Text('Start CTR'),
                          )
                        : null,
          ),
        ),
      const SizedBox(height: 16),
      Text('Currency transaction reports', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      if (ctrs.isEmpty) const Text('No reports yet.'),
      for (final c in ctrs) _CtrCard(c),
      const SizedBox(height: 8),
      const Refs([Aml.ref]),
    ]);
  }
}

class _CtrCard extends ConsumerWidget {
  final CtrReport c;
  const _CtrCard(this.c);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserValueProvider)!;
    final n = ref.read(complianceNotifierProvider.notifier);
    Future<void> save(ResultFuture<Object?> action, String m) async {
      final r = await action;
      if (context.mounted) r.fold((f) => showMsg(context, f.displayMessage, error: true), (_) => showMsg(context, m));
    }

    final canAct = user.can(Perm.complianceReview) || user.can(Perm.cashTransactions);
    return SectionCard(
      title: 'CTR · ${c.patronLabel} · ${money0(c.total)} · ${date(c.gamingDay)}',
      subtitle: '${c.aggregateLabel}${c.multiple ? ' — filed as a result of multiple transactions' : ''} · status ${c.status.label.toLowerCase()}',
      children: [
        for (final f in Aml.ctrRequiredFields.take(8))
          CheckboxListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            value: c.fields[f] == true,
            onChanged: c.status != CtrStatus.draft || !canAct ? null : (v) => save(n.setCtrField(c, f, v!), 'Updated'),
            title: Text(f),
          ),
        Text('Prepared by: ${c.preparedBy.isEmpty ? '—' : c.preparedBy} · Reviewed by: ${c.reviewedBy.isEmpty ? '—' : c.reviewedBy}'),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          if (c.status == CtrStatus.draft && canAct)
            FilledButton.tonal(
              onPressed: !c.complete ? null : () => save(n.advanceCtr(c, CtrStatus.prepared), 'Signed as preparer'),
              child: const Text('Sign as preparer'),
            ),
          if (c.status == CtrStatus.prepared && user.can(Perm.complianceReview))
            FilledButton.tonal(
              onPressed: c.preparedById == user.id ? null : () => save(n.advanceCtr(c, CtrStatus.reviewed), 'Reviewed'),
              child: Text(c.preparedById == user.id ? 'Reviewer must be a different employee' : 'Sign as reviewer'),
            ),
          if (c.status == CtrStatus.reviewed && user.can(Perm.complianceReview))
            FilledButton(onPressed: () => save(n.advanceCtr(c, CtrStatus.filed), 'Marked as filed'), child: const Text('Mark filed')),
        ]),
      ],
    );
  }
}

class _Barred extends ConsumerWidget {
  const _Barred();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserValueProvider);
    final list = ref.watch(barredProvider).value ?? const <BarredPatron>[];
    final players = ref.watch(playersProvider).value ?? const <Player>[];
    return PageBody(children: [
      Row(children: [
        Expanded(child: Text('Barred patron log', style: Theme.of(context).textTheme.titleLarge)),
        if (user?.can(Perm.complianceReview) == true || user?.can(Perm.cashTransactions) == true)
          FilledButton.icon(
            icon: const Icon(Icons.person_off_outlined),
            label: const Text('Bar patron'),
            onPressed: () async {
              String? pid;
              final desc = TextEditingController();
              final reason = TextEditingController(text: 'Refused to provide identification for a reportable transaction');
              await showDialog<void>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Bar patron'),
                  content: SizedBox(
                    width: 420,
                    child: Column(mainAxisSize: MainAxisSize.min, spacing: 16, children: [
                      DropdownButtonFormField<String?>(
                  isExpanded: true,
                        decoration: const InputDecoration(labelText: 'Known player'),
                        items: [const DropdownMenuItem<String?>(value: null, child: Text('Not a known player')), ...players.map((x) => DropdownMenuItem<String?>(value: x.id, child: Text(x.name)))],
                        onChanged: (v) => pid = v,
                      ),
                      TextField(controller: desc, decoration: const InputDecoration(labelText: 'Name / description')),
                      TextField(controller: reason, decoration: const InputDecoration(labelText: 'Reason'), maxLines: 2),
                    ]),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                    FilledButton(
                      onPressed: () async {
                        final d = desc.text.trim().isNotEmpty ? desc.text.trim() : players.where((x) => x.id == pid).map((x) => x.name).firstOrNull ?? '';
                        final r = await ref.read(complianceNotifierProvider.notifier).barPatron(description: d, reason: reason.text, playerId: pid ?? '');
                        if (!ctx.mounted) return;
                        r.fold((f) => showMsg(ctx, f.displayMessage, error: true), (_) => Navigator.pop(ctx));
                      },
                      child: const Text('Bar'),
                    ),
                  ],
                ),
              );
            },
          ),
      ]),
      const SizedBox(height: 8),
      const Callout('A patron who will not provide the information for a required report is barred from all gaming at all affiliated casinos until it is provided (p.69). All gaming and security staff should review this log routinely (p.72).'),
      if (list.isEmpty) const EmptyState('Nobody is barred.'),
      for (final b in list)
        Card(
          child: ListTile(
            leading: Icon(Icons.block, color: b.active ? Brand.danger : Colors.grey),
            title: Text(b.description),
            subtitle: Text('${b.reason} · since ${date(b.since)} · by ${b.addedBy}${b.active ? '' : ' · LIFTED'}'),
            trailing: b.active && user?.can(Perm.complianceReview) == true
                ? TextButton(
                    onPressed: () => ref.read(complianceNotifierProvider.notifier).liftBar(b),
                    child: const Text('Lift (info provided)'))
                : null,
          ),
        ),
    ]);
  }
}

class _Sar extends ConsumerWidget {
  const _Sar();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserValueProvider);
    final p = ref.watch(settingsProvider).aml;
    final list = (ref.watch(sarProvider).value ?? const <SarCase>[]).toList()..sort((a, b) => b.detectedAt.compareTo(a.detectedAt));
    final can = user?.can(Perm.complianceReview) == true;
    return PageBody(children: [
      Row(children: [
        Expanded(child: Text('Suspicious activity cases', style: Theme.of(context).textTheme.titleLarge)),
        if (can)
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Open case'),
            onPressed: () async {
              final subject = TextEditingController();
              final summary = TextEditingController();
              final amount = TextEditingController();
              await showDialog<void>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Open SAR case'),
                  content: SizedBox(
                    width: 440,
                    child: Column(mainAxisSize: MainAxisSize.min, spacing: 16, children: [
                      TextField(controller: subject, decoration: const InputDecoration(labelText: 'Subject')),
                      TextField(controller: amount, decoration: const InputDecoration(labelText: 'Amount involved', prefixText: '\$ '), keyboardType: TextInputType.number),
                      TextField(controller: summary, maxLines: 3, decoration: const InputDecoration(labelText: 'What was observed')),
                    ]),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                    FilledButton(
                      onPressed: () async {
                        final r = await ref
                            .read(complianceNotifierProvider.notifier)
                            .openSar(subject: subject.text, summary: summary.text, amount: parseNum(amount.text) ?? 0);
                        if (!ctx.mounted) return;
                        r.fold((f) => showMsg(ctx, f.displayMessage, error: true), (_) => Navigator.pop(ctx));
                      },
                      child: const Text('Open'),
                    ),
                  ],
                ),
              );
            },
          ),
      ]),
      const SizedBox(height: 8),
      Callout('File within ${p.sarFileDays} days of detection (+${p.sarExtensionDays} to identify a suspect) when ≥ ${money0(p.sarThreshold)} involves illegal funds, avoids a CTR, has no apparent lawful purpose, or facilitates crime. '
          'Never tell the patron a report was filed (p.78).'),
      if (list.isEmpty) const EmptyState('No open cases.'),
      for (final c in list)
        () {
          final due = c.dueDate(p);
          final left = due.difference(DateTime.now()).inDays;
          return Card(
            child: ListTile(
              title: Text('${c.subject} · ${money0(c.amount)}'),
              subtitle: Text('${c.summary}\nDetected ${date(c.detectedAt)} · due ${date(due)}${c.filedAt != null ? ' · FILED ${date(c.filedAt!)}' : ' · $left days left'}'),
              isThreeLine: true,
              trailing: c.filedAt != null || !can
                  ? null
                  : Wrap(spacing: 4, children: [
                      if (!c.extended)
                        TextButton(onPressed: () => ref.read(complianceNotifierProvider.notifier).extendSar(c), child: const Text('+30 days')),
                      FilledButton.tonal(onPressed: () => ref.read(complianceNotifierProvider.notifier).markSarFiled(c), child: const Text('Filed')),
                    ]),
            ),
          );
        }(),
    ]);
  }
}
