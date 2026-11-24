import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/sign_in_page.dart';
import '../../features/compliance/presentation/compliance_pages.dart';
import '../../features/credit/presentation/credit_pages.dart';
import '../../features/evaluate/presentation/evaluate_pages.dart';
import '../../features/home/home_page.dart';
import '../../features/library/presentation/library_page.dart';
import '../../features/players/presentation/players_pages.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../../features/staffing/presentation/staffing_page.dart';
import '../../features/tables/presentation/tables_pages.dart';
import '../auth/session.dart';
import 'shell_scaffold.dart';

/// Re-runs redirects when the signed-in user changes.
class _RouterRefresh extends ChangeNotifier {
  void ping() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh();
  ref.listen(currentUserProvider, (_, _) => refresh.ping());
  ref.onDispose(refresh.dispose);
  return GoRouter(
    refreshListenable: refresh,
    redirect: (context, state) {
      final signedIn = ref.read(currentUserProvider) != null;
      final atLogin = state.matchedLocation == '/sign-in';
      if (!signedIn) return atLogin ? null : '/sign-in';
      if (atLogin) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/sign-in', builder: (_, _) => const SignInPage()),
      ShellRoute(
        builder: (context, state, child) => ShellScaffold(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(path: '/', builder: (_, _) => const HomePage()),
          GoRoute(path: '/players', builder: (_, _) => const PlayersPage(), routes: [
            GoRoute(path: ':id', builder: (_, s) => PlayerDetailPage(playerId: s.pathParameters['id']!), routes: [
              GoRoute(path: 'rate', builder: (_, s) => RateSessionPage(playerId: s.pathParameters['id']!)),
            ]),
          ]),
          GoRoute(path: '/tables', builder: (_, _) => const TablesPage()),
          GoRoute(path: '/credit', builder: (_, _) => const CreditPage(), routes: [
            GoRoute(path: ':id', builder: (_, s) => CreditApplicationPage(appId: s.pathParameters['id']!)),
          ]),
          GoRoute(path: '/compliance', builder: (_, _) => const CompliancePage()),
          GoRoute(path: '/evaluate', builder: (_, _) => const EvaluatePage()),
          GoRoute(path: '/staffing', builder: (_, _) => const StaffingPage()),
          GoRoute(path: '/library', builder: (_, _) => const LibraryPage()),
          GoRoute(path: '/settings', builder: (_, _) => const SettingsPage()),
        ],
      ),
    ],
  );
});
