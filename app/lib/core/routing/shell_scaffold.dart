import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_notifier.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../flavors.dart';
import '../../shared/providers/backend_providers.dart';
import 'route_names.dart';

class NavItem {
  const NavItem(this.path, this.label, this.icon, this.short);
  final String path, label, short;
  final IconData icon;
}

/// Same order as the branches in app_router.dart.
const navItems = [
  NavItem(Routes.home, 'Home', Icons.dashboard_outlined, 'Home'),
  NavItem(Routes.players, 'Players & ratings', Icons.people_outline, 'Players'),
  NavItem(Routes.tables, 'Table games & hold', Icons.table_restaurant_outlined, 'Tables'),
  NavItem(Routes.credit, 'Credit & markers', Icons.credit_score_outlined, 'Credit'),
  NavItem(Routes.compliance, 'Currency compliance', Icons.policy_outlined, 'Compliance'),
  NavItem(Routes.evaluate, 'Promotions & deals', Icons.calculate_outlined, 'Promotions'),
  NavItem(Routes.staffing, 'Staffing', Icons.groups_2_outlined, 'Staffing'),
  NavItem(Routes.library, 'Knowledge library', Icons.menu_book_outlined, 'Library'),
  NavItem(Routes.settings, 'Settings', Icons.settings_outlined, 'Settings'),
];

/// Rail on wide screens (≥1000 px), drawer otherwise. Each tab keeps its own stack.
class ShellScaffold extends ConsumerWidget {
  const ShellScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _go(int i) => navigationShell.goBranch(i, initialLocation: i == navigationShell.currentIndex);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = navigationShell.currentIndex;
    final wide = MediaQuery.sizeOf(context).width >= 1000;
    final user = ref.watch(currentUserValueProvider);
    final mode = ref.watch(recordStoreProvider).modeLabel;
    final title = Text(navItems[idx].label);
    final userMenu = PopupMenuButton<String>(
      tooltip: 'Account',
      icon: const Icon(Icons.account_circle_outlined),
      itemBuilder: (_) => [
        PopupMenuItem(enabled: false, child: Text('${user?.name ?? ''}\n${user?.role.label ?? ''}\n$mode · ${F.name}')),
        const PopupMenuItem(value: 'out', child: Text('Switch user / sign out')),
      ],
      onSelected: (_) => ref.read(authNotifierProvider.notifier).signOut(),
    );
    if (wide) {
      return Scaffold(
        appBar: AppBar(title: title, actions: [userMenu]),
        body: Row(children: [
          NavigationRail(
            extended: true,
            minExtendedWidth: 230,
            selectedIndex: idx,
            onDestinationSelected: _go,
            destinations: navItems.map((n) => NavigationRailDestination(icon: Icon(n.icon), label: Text(n.label))).toList(),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: navigationShell),
        ]),
      );
    }
    return Scaffold(
      appBar: AppBar(title: title, actions: [userMenu]),
      drawer: NavigationDrawer(
        selectedIndex: idx,
        onDestinationSelected: (i) {
          Navigator.pop(context);
          _go(i);
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 20, 16, 10),
            child: Text(F.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          ...navItems.map((n) => NavigationDrawerDestination(icon: Icon(n.icon), label: Text(n.short))),
        ],
      ),
      body: navigationShell,
    );
  }
}
