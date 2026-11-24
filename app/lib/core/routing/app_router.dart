import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/compliance/presentation/pages/compliance_pages.dart';
import '../../features/credit/presentation/pages/credit_pages.dart';
import '../../features/evaluate/presentation/pages/evaluate_pages.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/library/presentation/pages/library_page.dart';
import '../../features/players/presentation/pages/players_pages.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/staffing/presentation/pages/staffing_page.dart';
import '../../features/tables/presentation/pages/tables_pages.dart';
import 'route_names.dart';
import 'shell_scaffold.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Re-runs redirects when sign-in state or the operator's profile changes.
class _RouterRefresh extends ChangeNotifier {
  void ping() => notifyListeners();
}

/// Internal staff tool: unlike a consumer app there is no guest browsing, so
/// every path except sign-in requires an operator with a CMS role.
bool _requiresAuth(String loc) => loc != Routes.signIn;

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh();
  ref.listen(authUidProvider, (_, _) => refresh.ping());
  ref.listen(currentUserProvider, (_, _) => refresh.ping());
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    refreshListenable: refresh,
    redirect: (context, state) {
      final uid = ref.read(authUidProvider);
      final user = ref.read(currentUserProvider);
      // Still resolving the session: stay put rather than bounce through sign-in.
      if (uid.isLoading || (uid.value != null && user.isLoading)) return null;
      final signedIn = user.value != null;
      final loc = state.matchedLocation;
      if (!signedIn) {
        if (!_requiresAuth(loc)) return null;
        return Uri(path: Routes.signIn, queryParameters: loc == Routes.home ? null : {'from': state.uri.toString()}).toString();
      }
      if (loc == Routes.signIn) return state.uri.queryParameters['from'] ?? Routes.home;
      return null;
    },
    routes: [
      GoRoute(path: Routes.signIn, builder: (_, _) => const SignInPage()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ShellScaffold(navigationShell: shell),
        branches: [
          _branch(Routes.home, const HomePage()),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.players, builder: (_, _) => const PlayersPage(), routes: [
              GoRoute(path: ':id', builder: (_, s) => PlayerDetailPage(playerId: s.pathParameters['id']!), routes: [
                // Full-screen flow pushed over the shell.
                GoRoute(
                  path: 'rate',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (_, s) => RateSessionPage(playerId: s.pathParameters['id']!),
                ),
              ]),
            ]),
          ]),
          _branch(Routes.tables, const TablesPage()),
          StatefulShellBranch(routes: [
            GoRoute(path: Routes.credit, builder: (_, _) => const CreditPage(), routes: [
              GoRoute(path: ':id', builder: (_, s) => CreditApplicationPage(appId: s.pathParameters['id']!)),
            ]),
          ]),
          _branch(Routes.compliance, const CompliancePage()),
          _branch(Routes.evaluate, const EvaluatePage()),
          _branch(Routes.staffing, const StaffingPage()),
          _branch(Routes.library, const LibraryPage()),
          _branch(Routes.settings, const SettingsPage()),
        ],
      ),
    ],
  );
});

StatefulShellBranch _branch(String path, Widget page) =>
    StatefulShellBranch(routes: [GoRoute(path: path, builder: (_, _) => page)]);
