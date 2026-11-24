import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_notifier.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../flavors.dart';
import '../theme/theme.dart';
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

/// Tabs in the floating bottom bar on phones; the rest open from "More".
const _bottomTabs = [0, 1, 2, 3];

/// Green sidebar on wide screens (≥1000 px); floating bottom bar + drawer on phones.
/// Each tab keeps its own stack.
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
    final p = AppPalette.of(context);
    final userMenu = PopupMenuButton<String>(
      tooltip: 'Account',
      offset: const Offset(0, 48),
      itemBuilder: (_) => [
        PopupMenuItem(enabled: false, child: Text('${user?.name ?? ''}\n${user?.role.label ?? ''}\n$mode · ${F.name}')),
        const PopupMenuItem(value: 'out', child: Text('Switch user / sign out')),
      ],
      onSelected: (_) => ref.read(authNotifierProvider.notifier).signOut(),
      child: Padding(padding: const EdgeInsets.only(right: 12, left: 4), child: _Avatar(name: user?.name ?? '')),
    );
    final appBar = AppBar(
      title: Text(wide ? navItems[idx].label : navItems[idx].short),
      actions: [userMenu],
    );

    if (wide) {
      return Scaffold(
        body: Row(children: [
          Container(
            width: 250,
            decoration: BoxDecoration(gradient: p.heroGradient),
            child: SafeArea(
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 16, 20),
                  child: Row(children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: p.accent, borderRadius: BorderRadius.circular(Radii.field)),
                      child: Icon(Icons.casino_outlined, color: p.onAccent, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Flexible(child: Text(F.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800))),
                  ]),
                ),
                Expanded(
                  child: ListView(padding: const EdgeInsets.symmetric(horizontal: 12), children: [
                    for (var i = 0; i < navItems.length; i++)
                      _SideItem(item: navItems[i], selected: i == idx, onTap: () => _go(i)),
                  ]),
                ),
              ]),
            ),
          ),
          Expanded(child: Scaffold(appBar: appBar, body: navigationShell)),
        ]),
      );
    }

    final tabIdx = _bottomTabs.indexOf(idx);
    return Scaffold(
      appBar: appBar,
      extendBody: true,
      drawer: NavigationDrawer(
        selectedIndex: idx,
        onDestinationSelected: (i) {
          Navigator.pop(context);
          _go(i);
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 20, 16, 12),
            child: Text(F.title, style: Theme.of(context).textTheme.titleLarge),
          ),
          ...navItems.map((n) => NavigationDrawerDestination(icon: Icon(n.icon), label: Text(n.short))),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: Builder(
        builder: (context) => _FloatingNavBar(
          selected: tabIdx < 0 ? _bottomTabs.length : tabIdx,
          items: [for (final i in _bottomTabs) (navItems[i].icon, navItems[i].short), (Icons.grid_view_rounded, 'More')],
          onTap: (i) => i < _bottomTabs.length ? _go(_bottomTabs[i]) : Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final initials = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).take(2).map((w) => w[0].toUpperCase()).join();
    return CircleAvatar(
      radius: 19,
      backgroundColor: p.tile,
      child: initials.isEmpty
          ? Icon(Icons.person_outline, color: p.onTile, size: 20)
          : Text(initials, style: TextStyle(color: p.onTile, fontWeight: FontWeight.w700, fontSize: 14)),
    );
  }
}

class _SideItem extends StatelessWidget {
  const _SideItem({required this.item, required this.selected, required this.onTap});
  final NavItem item;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected ? p.navSelected : Colors.transparent,
        borderRadius: BorderRadius.circular(Radii.tile),
        child: InkWell(
          borderRadius: BorderRadius.circular(Radii.tile),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(children: [
              Icon(item.icon, size: 22, color: selected ? p.accent : p.onNavBar),
              const SizedBox(width: 12),
              Expanded(
                child: Text(item.label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: selected ? Colors.white : p.onNavBar, fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

/// The rounded dark-green bar floating above the content (phones).
class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({required this.selected, required this.items, required this.onTap});
  final int selected;
  final List<(IconData, String)> items;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: p.navBar,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.18), blurRadius: 20, offset: const Offset(0, 8))],
        ),
        child: Row(children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              child: Semantics(
                button: true,
                selected: i == selected,
                label: items[i].$2,
                child: InkWell(
                  borderRadius: BorderRadius.circular(Radii.tile + 2),
                  onTap: () => onTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: i == selected ? p.navSelected : Colors.transparent,
                      borderRadius: BorderRadius.circular(Radii.tile + 2),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(items[i].$1, size: 22, color: i == selected ? p.accent : p.onNavBar),
                      const SizedBox(height: 3),
                      Text(items[i].$2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: i == selected ? Colors.white : p.onNavBar,
                              fontWeight: i == selected ? FontWeight.w700 : FontWeight.w500)),
                    ]),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
