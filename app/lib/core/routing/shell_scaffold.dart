import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/session.dart';
import '../../shared/providers.dart';

class NavItem {
  final String path, label, short;
  final IconData icon;
  const NavItem(this.path, this.label, this.icon, this.short);
}

const navItems = [
  NavItem('/', 'Home', Icons.dashboard_outlined, 'Home'),
  NavItem('/players', 'Players & ratings', Icons.people_outline, 'Players'),
  NavItem('/tables', 'Table games & hold', Icons.table_restaurant_outlined, 'Tables'),
  NavItem('/credit', 'Credit & markers', Icons.credit_score_outlined, 'Credit'),
  NavItem('/compliance', 'Currency compliance', Icons.policy_outlined, 'Compliance'),
  NavItem('/evaluate', 'Promotions & deals', Icons.calculate_outlined, 'Promotions'),
  NavItem('/staffing', 'Staffing', Icons.groups_2_outlined, 'Staffing'),
  NavItem('/library', 'Knowledge library', Icons.menu_book_outlined, 'Library'),
  NavItem('/settings', 'Settings', Icons.settings_outlined, 'Settings'),
];

int _indexFor(String loc) {
  var best = 0;
  for (var i = 1; i < navItems.length; i++) {
    if (loc.startsWith(navItems[i].path)) best = i;
  }
  return best;
}

class ShellScaffold extends ConsumerWidget {
  final Widget child;
  final String location;
  const ShellScaffold({super.key, required this.child, required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = _indexFor(location);
    final wide = MediaQuery.sizeOf(context).width >= 1000;
    final user = ref.watch(currentUserProvider);
    final mode = ref.watch(recordStoreProvider).modeLabel;
    final title = Text(navItems[idx].label);
    final userMenu = PopupMenuButton<String>(
      tooltip: 'Account',
      icon: const Icon(Icons.account_circle_outlined),
      itemBuilder: (_) => [
        PopupMenuItem(enabled: false, child: Text('${user?.name ?? ''}\n${user?.role.label ?? ''}\n$mode')),
        const PopupMenuItem(value: 'out', child: Text('Switch user / sign out')),
      ],
      onSelected: (v) => ref.read(sessionProvider.notifier).signOut(),
    );
    if (wide) {
      return Scaffold(
        appBar: AppBar(title: title, actions: [userMenu]),
        body: Row(children: [
          NavigationRail(
            extended: true,
            minExtendedWidth: 230,
            selectedIndex: idx,
            onDestinationSelected: (i) => context.go(navItems[i].path),
            destinations: navItems.map((n) => NavigationRailDestination(icon: Icon(n.icon), label: Text(n.label))).toList(),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ]),
      );
    }
    return Scaffold(
      appBar: AppBar(title: title, actions: [userMenu]),
      drawer: NavigationDrawer(
        selectedIndex: idx,
        onDestinationSelected: (i) {
          Navigator.pop(context);
          context.go(navItems[i].path);
        },
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(28, 20, 16, 10), child: Text('CMS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
          ...navItems.map((n) => NavigationDrawerDestination(icon: Icon(n.icon), label: Text(n.short))),
        ],
      ),
      body: child,
    );
  }
}
