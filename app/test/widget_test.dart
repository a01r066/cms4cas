import 'package:cms_kiss/app/app.dart';
import 'package:cms_kiss/core/routing/app_router.dart';
import 'package:cms_kiss/core/routing/route_names.dart';
import 'package:cms_kiss/shared/providers/backend_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void _wide(WidgetTester t) {
  t.view.physicalSize = const Size(1400, 1000);
  t.view.devicePixelRatio = 1;
  addTearDown(t.view.reset);
}

Future<ProviderContainer> _pumpApp(WidgetTester tester, {Map<String, Object> prefs = const {}, Future<void> Function(ProviderContainer)? seed}) async {
  final c = ProviderContainer(overrides: await localOverrides(prefs));
  addTearDown(c.dispose);
  if (seed != null) await seed(c);
  await tester.pumpWidget(UncontrolledProviderScope(container: c, child: const CmsApp()));
  await tester.pumpAndSettle();
  return c;
}

Future<void> _seedUser(ProviderContainer c, String id, String name, String role, {String? creditRole}) async {
  await c.read(recordStoreProvider).put('users', id, {'id': id, 'name': name, 'role': role, 'creditRole': creditRole});
}

void main() {
  testWidgets('First run: create admin, land on Home, open every module', (tester) async {
    _wide(tester);
    await _pumpApp(tester);
    expect(find.text('Create administrator'), findsOneWidget);
    await tester.tap(find.text('Create administrator'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Thanh Admin');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Thanh Admin'), findsWidgets);
    for (final label in ['Players & ratings', 'Table games & hold', 'Credit & markers', 'Currency compliance', 'Promotions & deals', 'Staffing', 'Knowledge library', 'Settings', 'Home']) {
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: label);
    }
  });

  testWidgets('Phone layout: every module renders without overflow', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await _pumpApp(tester, prefs: {'cms.currentUserId': 'u1'}, seed: (c) => _seedUser(c, 'u1', 'Pit Boss', 'admin', creditRole: 'credit_manager'));
    for (final label in ['Players', 'Tables', 'Credit', 'Compliance', 'Promotions', 'Staffing', 'Library', 'Settings']) {
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: label);
    }
  });

  testWidgets('Corrupted local data shows an error instead of hanging', (tester) async {
    await _pumpApp(tester, prefs: {'cms.users': 'not json'});
    expect(find.textContaining('could not be read'), findsOneWidget);
  });

  testWidgets('Deep link while signed out returns there after sign-in', (tester) async {
    _wide(tester);
    final c = await _pumpApp(tester, seed: (c) => _seedUser(c, 'u1', 'Floor', 'pit_supervisor'));
    c.read(routerProvider).go(Routes.tables);
    await tester.pumpAndSettle();
    expect(find.text('Floor'), findsOneWidget, reason: 'redirected to sign-in');
    await tester.tap(find.text('Floor'));
    await tester.pumpAndSettle();
    expect(find.text('Hold dashboard'), findsOneWidget, reason: 'back on the requested page');
  });

  testWidgets('Tabs keep their own stack (StatefulShellRoute)', (tester) async {
    _wide(tester);
    final c = await _pumpApp(tester, prefs: {'cms.currentUserId': 'u1'}, seed: (c) async {
      await _seedUser(c, 'u1', 'Floor', 'pit_supervisor');
      await c.read(recordStoreProvider).put('players', 'p1', {'id': 'p1', 'name': 'Jim Kilby', 'createdAt': '2026-01-01T00:00:00.000'});
    });
    c.read(routerProvider).go(Routes.player('p1'));
    await tester.pumpAndSettle();
    expect(find.text('Jim Kilby'), findsWidgets);
    await tester.tap(find.text('Table games & hold').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Players & ratings').last);
    await tester.pumpAndSettle();
    expect(find.text('Player value (all rated play)'), findsOneWidget, reason: 'player detail kept in the Players tab');
  });

  testWidgets('Workflow: rate a blackjack session through the form → theo saved (Ch12)', (tester) async {
    _wide(tester);
    final c = await _pumpApp(tester, prefs: {'cms.currentUserId': 'u1'}, seed: (c) async {
      await _seedUser(c, 'u1', 'Floor', 'pit_supervisor');
      await c.read(recordStoreProvider).put('players', 'p1', {'id': 'p1', 'name': 'Jim Kilby', 'createdAt': '2026-01-01T00:00:00.000'});
    });
    c.read(routerProvider).go(Routes.ratePlayer('p1'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Average initial bet'), '500');
    await tester.enterText(find.widgetWithText(TextFormField, 'Time played'), '120');
    await tester.pumpAndSettle();
    expect(find.text('\$766.50'), findsOneWidget); // 500 × 2h × 105 hands (3 players) × 0.73%
    await tester.tap(find.text('Save rating'));
    await tester.pumpAndSettle();
    final saved = await c.read(recordStoreProvider).list('ratings');
    expect(saved, hasLength(1));
    expect((saved.single['theo'] as num).toDouble(), closeTo(766.5, 0.001));
    expect(saved.single['ratedBy'], 'Floor');
    expect(find.text('Player value (all rated play)'), findsOneWidget, reason: 'returned to the player');
  });
}
