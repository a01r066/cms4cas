import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../auth/domain/entities/app_role.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/demo_data_generator.dart';
import '../providers/demo_data_notifier.dart';
import '../providers/demo_data_providers.dart';

/// Settings → Demo data (admins). Loads a realistic data set touching every
/// feature, or removes it again. Firebase projects are seeded by script.
class DemoDataCard extends ConsumerWidget {
  const DemoDataCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(currentUserValueProvider);
    if (me?.can(Perm.manageUsers) != true) return const SizedBox.shrink();
    final available = ref.watch(demoDataAvailableProvider);
    final present = ref.watch(demoDataPresentProvider).value ?? false;
    final busy = ref.watch(demoDataNotifierProvider).busy;
    final notifier = ref.read(demoDataNotifierProvider.notifier);

    return SectionCard(
      title: 'Demo data',
      subtitle: 'Players, ratings, tables, credit, markers and compliance records for trying out every screen. '
          'All demo records have ids starting with "${DemoData.prefix}".',
      children: [
        if (!available)
          const Callout('This build uses Firebase. Seed the dev project from a terminal:\n'
              'tool/seed_demo_data.sh            (load)\n'
              'tool/seed_demo_data.sh --remove   (remove)\n'
              'The script refuses the production project.')
        else ...[
          Text(present ? 'Demo data is loaded.' : 'No demo data on this device.'),
          const SizedBox(height: 4),
          Text('Demo staff appear in the sign-in list (admin, casino manager, credit, host, pit, cage, compliance, auditor).',
              style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: [
            FilledButton.tonalIcon(
              key: const Key('demo-load'),
              icon: const Icon(Icons.dataset_outlined),
              label: Text(present ? 'Reload demo data' : 'Load demo data'),
              onPressed: busy
                  ? null
                  : () async {
                      final r = await notifier.load();
                      if (context.mounted) {
                        r.fold((f) => showMsg(context, f.displayMessage, error: true), (n) => showMsg(context, 'Loaded $n demo records'));
                      }
                    },
            ),
            OutlinedButton.icon(
              key: const Key('demo-remove'),
              icon: const Icon(Icons.delete_sweep_outlined),
              label: const Text('Remove demo data'),
              onPressed: busy || !present
                  ? null
                  : () async {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (c) => AlertDialog(
                          title: const Text('Remove demo data?'),
                          content: const Text('Deletes every demo record on this device. Your own records and your user profile are kept.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                            FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Remove')),
                          ],
                        ),
                      );
                      if (ok != true) return;
                      final r = await notifier.remove();
                      if (context.mounted) {
                        r.fold((f) => showMsg(context, f.displayMessage, error: true), (n) => showMsg(context, 'Removed $n demo records'));
                      }
                    },
            ),
            if (busy) const Padding(padding: EdgeInsets.all(8), child: SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))),
          ]),
        ],
      ],
    );
  }
}
