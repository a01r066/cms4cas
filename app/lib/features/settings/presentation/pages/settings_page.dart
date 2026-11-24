import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/entities/access_request.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../auth/presentation/widgets/user_form.dart';
import '../../../../core/util/fmt.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/domain/entities/app_role.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/app_settings.dart';
import '../providers/settings_notifier.dart';
import '../providers/settings_providers.dart';
import '../../../../shared/providers/backend_providers.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});
  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final form = GlobalKey<FormState>();
  final c = <String, TextEditingController>{};
  AppSettings? loaded;
  AggregationRegime regime = AggregationRegime.reg6a;
  bool quickLoss = true;

  TextEditingController t(String k) => c.putIfAbsent(k, () => TextEditingController());

  void _load(AppSettings s) {
    loaded = s;
    regime = s.aml.regime;
    quickLoss = s.comps.quickLossEnabled;
    t('name').text = s.casinoName;
    t('jur').text = s.jurisdictionLabel;
    t('ctr').text = numf(s.aml.ctrThreshold);
    t('mtl').text = numf(s.aml.mtlThreshold);
    t('c4c').text = numf(s.aml.cashForCashLimit);
    t('chk').text = numf(s.aml.casinoCheckForCashLimit);
    t('sar').text = numf(s.aml.sarThreshold);
    t('sarDays').text = '${s.aml.sarFileDays}';
    t('sarExt').text = '${s.aml.sarExtensionDays}';
    t('dayStart').text = '${s.aml.gamingDayStartHour}';
    t('near').text = (s.aml.nearThresholdPct * 100).toStringAsFixed(0);
    t('compTheo').text = (s.comps.pctOfTheo * 100).toStringAsFixed(0);
    t('compLoss').text = (s.comps.quickLossPctOfActual * 100).toStringAsFixed(0);
    t('tax').text = (s.gamingTaxRate * 100).toStringAsFixed(2);
    t('tol').text = (s.holdTolerance * 100).toStringAsFixed(1);
    t('hit').text = numf(s.ratingHitThreshold);
    for (final g in s.games) {
      t('ha_${g.id}').text = (g.houseAdvantage * 100).toStringAsFixed(3);
      for (final pt in PlayerType.values) {
        final m = g.multipliers[pt];
        t('m_${g.id}_${pt.wire}').text = m == null ? '' : m.toString();
      }
    }
  }

  AppSettings _collect() {
    double n(String k) => parseNum(t(k).text) ?? 0;
    final ha = <String, double>{};
    final mult = <String, Map<String, double?>>{};
    for (final g in RatingDefaults.games) {
      ha[g.id] = n('ha_${g.id}') / 100;
      mult[g.id] = {for (final pt in PlayerType.values) pt.wire: parseNum(t('m_${g.id}_${pt.wire}').text)};
    }
    return loaded!.copyWith(
      casinoName: t('name').text.trim(),
      jurisdictionLabel: t('jur').text.trim(),
      aml: AmlProfile(
        regime: regime, ctrThreshold: n('ctr'), mtlThreshold: n('mtl'), cashForCashLimit: n('c4c'), casinoCheckForCashLimit: n('chk'),
        sarThreshold: n('sar'), sarFileDays: n('sarDays').round(), sarExtensionDays: n('sarExt').round(), gamingDayStartHour: n('dayStart').round(),
        nearThresholdPct: n('near') / 100,
      ),
      comps: CompPolicy(pctOfTheo: n('compTheo') / 100, quickLossPctOfActual: n('compLoss') / 100, quickLossEnabled: quickLoss),
      gamingTaxRate: n('tax') / 100,
      holdTolerance: n('tol') / 100,
      ratingHitThreshold: n('hit'),
      houseAdvantage: ha,
      multipliers: mult,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserValueProvider);
    final s = ref.watch(settingsProvider);
    final store = ref.watch(recordStoreProvider);
    if (loaded == null || (loaded != s && !_dirty)) _load(s);
    final admin = user?.can(Perm.settings) == true;
    return Scaffold(
      body: PageBody(maxWidth: 1000, children: [
        Callout('Data: ${store.modeLabel}. Values marked with a book reference are the 2003 Nevada/Atlantic City figures — set them to your jurisdiction\'s current rules before use.'),
        if (!admin) const NoAccess('changing settings (view only)'),
        Form(
          key: form,
          onChanged: () => _dirty = true,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SectionCard(title: 'Casino', children: [
              FieldGrid(children: [
                TextFormField(controller: t('name'), enabled: admin, decoration: const InputDecoration(labelText: 'Casino name')),
                TextFormField(controller: t('jur'), enabled: admin, decoration: const InputDecoration(labelText: 'Jurisdiction profile name')),
                NumField(label: 'Gaming tax rate (for promotion costing)', controller: t('tax'), suffix: '%', min: 0, max: 100),
              ]),
            ]),
            SectionCard(title: 'Currency transaction rules', trailing: const BookRefChip(Aml.ref), children: [
              DropdownButtonFormField<AggregationRegime>(
                  isExpanded: true,
                initialValue: regime,
                decoration: const InputDecoration(labelText: 'Aggregation regime'),
                items: AggregationRegime.values.map((r) => DropdownMenuItem(value: r, child: Text(r.label))).toList(),
                onChanged: admin ? (v) => setState(() { regime = v!; _dirty = true; }) : null,
              ),
              const SizedBox(height: 12),
              FieldGrid(children: [
                NumField(label: 'Report when total exceeds', controller: t('ctr'), prefix: '\$ ', min: 0),
                NumField(label: 'Log (MTL) transactions over', controller: t('mtl'), prefix: '\$ ', min: 0),
                NumField(label: 'Cash-for-cash limit (Reg 6A)', controller: t('c4c'), prefix: '\$ ', min: 0),
                NumField(label: 'Casino check for cash limit', controller: t('chk'), prefix: '\$ ', min: 0),
                NumField(label: 'Suspicious activity threshold', controller: t('sar'), prefix: '\$ ', min: 0),
                NumField(label: 'SAR filing days', controller: t('sarDays'), integer: true, min: 1),
                NumField(label: 'SAR extension days', controller: t('sarExt'), integer: true, min: 0),
                NumField(label: 'Gaming day starts at hour', controller: t('dayStart'), integer: true, min: 0, max: 23),
                NumField(label: 'Warn when total reaches', controller: t('near'), suffix: '% of threshold', min: 0, max: 100),
              ]),
            ]),
            SectionCard(title: 'Comp policy', trailing: const BookRefChip(Comps.ref), children: [
              FieldGrid(children: [
                NumField(label: 'Comps as % of theoretical win', controller: t('compTheo'), suffix: '%', min: 0, max: 100, helper: 'Book: 35–50% (p.310)'),
                NumField(label: 'Quick-loss comps as % of actual loss', controller: t('compLoss'), suffix: '%', min: 0, max: 100),
                SwitchListTile(contentPadding: EdgeInsets.zero, title: const Text('Quick-loss policy'), value: quickLoss,
                    onChanged: admin ? (v) => setState(() { quickLoss = v; _dirty = true; }) : null),
              ]),
            ]),
            SectionCard(title: 'Table games', children: [
              FieldGrid(children: [
                NumField(label: 'Hold variance to investigate (±)', controller: t('tol'), suffix: 'points', min: 0, helper: 'Nevada: 3 points (p.204)'),
                NumField(label: 'Documented "hit" threshold', controller: t('hit'), prefix: '\$ ', min: 0, helper: 'e.g. \$10,000 Mirage, \$2,500 Sahara (p.249)'),
              ]),
            ]),
            SectionCard(title: 'Rating parameters', subtitle: 'System house advantage × player-type multiplier (Ch12). Leave a multiplier blank if that type is not used.', trailing: const BookRefChip(RatingDefaults.ref), children: [
              for (final g in RatingDefaults.games)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(g.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    FieldGrid(minWidth: 150, children: [
                      NumField(label: 'House advantage', controller: t('ha_${g.id}'), suffix: '%', min: 0, max: 100),
                      for (final pt in PlayerType.values) NumField(label: '${pt.label} ×', controller: t('m_${g.id}_${pt.wire}'), min: 0, max: 10, required: false),
                    ]),
                  ]),
                ),
            ]),
          ]),
        ),
        if (admin)
          Wrap(alignment: WrapAlignment.end, spacing: 8, children: [
            TextButton(
              onPressed: () async {
                final ok = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                      title: const Text('Reset to book defaults?'),
                      content: const Text('All thresholds, comp policy and rating parameters return to the book\'s values. Casino name is kept.'),
                      actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Reset'))],
                    ));
                if (ok != true) return;
                final r = await ref.read(settingsNotifierProvider.notifier).resetToBookDefaults(s);
                if (!context.mounted) return;
                r.fold((f) => showMsg(context, f.displayMessage, error: true), (_) {
                  _dirty = false;
                  loaded = null;
                  showMsg(context, 'Settings reset to book defaults');
                });
              },
              child: const Text('Reset to book defaults'),
            ),
            FilledButton.icon(
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save settings'),
              onPressed: () async {
                if (!form.currentState!.validate()) return;
                final r = await ref.read(settingsNotifierProvider.notifier).save(_collect());
                if (!context.mounted) return;
                r.fold((f) => showMsg(context, f.displayMessage, error: true), (_) {
                  _dirty = false;
                  showMsg(context, 'Settings saved');
                });
              },
            ),
          ]),
        const SizedBox(height: 16),
        const _UsersCard(),
      ]),
    );
  }

  bool _dirty = false;
}

class _UsersCard extends ConsumerWidget {
  const _UsersCard();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(currentUserValueProvider);
    final users = ref.watch(usersProvider).value ?? const <AppUser>[];
    final canManage = me?.can(Perm.manageUsers) == true;
    final requests = ref.watch(accessRequestsProvider).value ?? const <AccessRequest>[];
    return SectionCard(
      title: 'Users and roles',
      subtitle: 'Credit signing authority follows Table 6.2',
      trailing: canManage ? FilledButton.tonalIcon(onPressed: () => showUserForm(context, ref), icon: const Icon(Icons.person_add_alt), label: const Text('Add user')) : null,
      children: [
        if (canManage && requests.isNotEmpty) ...[
          Text('Waiting for a role (${requests.length})', style: Theme.of(context).textTheme.titleSmall),
          for (final r in requests)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.hourglass_top_outlined),
              title: Text(r.name),
              subtitle: Text('${r.email} · registered ${dateTime(r.requestedAt)}'),
              trailing: Wrap(spacing: 4, children: [
                TextButton(
                  onPressed: () async {
                    final res = await ref.read(authNotifierProvider.notifier).dismissRequest(r);
                    if (context.mounted) res.fold((f) => showMsg(context, f.displayMessage, error: true), (_) => showMsg(context, 'Request dismissed'));
                  },
                  child: const Text('Dismiss'),
                ),
                FilledButton.tonal(onPressed: () => showUserForm(context, ref, request: r), child: const Text('Assign role')),
              ]),
            ),
          const Divider(),
        ],
        for (final u in users)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.badge_outlined),
            title: Text(u.name + (u.id == me?.id ? '  (you)' : '')),
            subtitle: Text('${u.role.label}${u.creditRole == null ? '' : ' · signs credit as ${u.creditRole!.label}'}'),
            trailing: canManage ? IconButton(tooltip: 'Edit', icon: const Icon(Icons.edit_outlined), onPressed: () => showUserForm(context, ref, existing: u)) : null,
          ),
      ],
    );
  }
}
