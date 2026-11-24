import 'package:casino_engine/casino_engine.dart';
import 'package:cms_kiss/app/app.dart';
import 'package:cms_kiss/core/auth/roles.dart';
import 'package:cms_kiss/core/data/local_record_store.dart';
import 'package:cms_kiss/core/data/repository.dart';
import 'package:cms_kiss/core/routing/app_router.dart';
import 'package:cms_kiss/features/compliance/data/compliance_models.dart';
import 'package:cms_kiss/features/credit/data/credit_models.dart';
import 'package:cms_kiss/features/players/data/models.dart';
import 'package:cms_kiss/features/settings/data/settings.dart';
import 'package:cms_kiss/features/tables/data/table_models.dart';
import 'package:cms_kiss/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<(SharedPreferences, LocalRecordStore)> _store([Map<String, Object> init = const {}]) async {
  SharedPreferences.setMockInitialValues(init);
  final p = await SharedPreferences.getInstance();
  return (p, LocalRecordStore(p));
}

void main() {
  group('Persistence', () {
    test('Local store round-trips and streams updates', () async {
      final (_, s) = await _store();
      final repo = Repository<Player>(s, 'players', Player.fromJson, (p) => p.toJson());
      final events = <int>[];
      final sub = repo.watch().listen((l) => events.add(l.length));
      await Future<void>.delayed(Duration.zero);
      await repo.save('p1', Player(id: 'p1', name: 'Jim Kilby', createdBy: 'test', createdAt: DateTime(2026)));
      await Future<void>.delayed(Duration.zero);
      final got = (await repo.get('p1')).getOrElse(() => null);
      expect(got?.name, 'Jim Kilby');
      expect(events.last, 1);
      await sub.cancel();
    });

    test('Settings survive a JSON round trip with overrides', () {
      final s = const AppSettings().copyWith(
        houseAdvantage: {'blackjack': 0.005},
        multipliers: {'craps': {'soft': 0.7, 'average': 0.4, 'hard': null}},
        aml: const AmlProfile(regime: AggregationRegime.title31, ctrThreshold: 15000),
      );
      final back = AppSettings.fromJson({...s.toJson()});
      expect(back.game('blackjack').houseAdvantage, 0.005);
      expect(back.game('craps').multipliers[PlayerType.soft], 0.7);
      expect(back.aml.regime, AggregationRegime.title31);
      expect(back.aml.ctrThreshold, 15000);
    });

    test('Table shift stores computed drop/win/hold', () {
      final t = TableShift(id: 's', tableId: 't', shift: 'Day', recordedBy: 'x', gamingDay: DateTime(2026), recordedAt: DateTime(2026),
          input: const TableShiftInput(openingInventory: 140000, fills: 50000, credits: 10000, closingInventory: 110000, currencyInBox: 60000, markersIssued: 100000, markersRedeemedInPitCheques: 70000));
      final j = t.toJson();
      expect(j['win'], 20000);
      expect(TableShift.fromJson({...j, 'id': 's'}).result.drop, 90000);
    });
  });

  group('Business rules in the app layer', () {
    test('Available credit = latest approved line − open markers', () {
      final apps = [
        CreditApplication(id: 'a', playerId: 'p', createdBy: '', lineType: LineType.permanent, amount: 10000, status: CreditStatus.approved, createdAt: DateTime(2026), decidedAt: DateTime(2026)),
        CreditApplication(id: 'b', playerId: 'p', createdBy: '', lineType: LineType.temporary, amount: 12500, status: CreditStatus.approved, createdAt: DateTime(2026, 2), decidedAt: DateTime(2026, 2)),
        CreditApplication(id: 'c', playerId: 'p', createdBy: '', lineType: LineType.permanent, amount: 99999, status: CreditStatus.declined, createdAt: DateTime(2026, 3)),
      ];
      final markers = [Marker(id: 'm', playerId: 'p', number: '1', table: 'BJ1', issuedBy: '', amount: 5000, issuedAt: DateTime(2026), payments: [MarkerPayment(1000, 'Check', '', DateTime(2026))])];
      final a = availableCredit(apps, markers, 'p');
      expect(a.line, 12500);
      expect(a.outstanding, 4000);
      expect(a.available, 8500);
    });

    test('Trip summary uses time-weighted average bet (Ch19 p.364)', () {
      RatingRecord r(double bet, double h) => RatingRecord(id: '$bet', playerId: 'p', gameId: 'blackjack', gameName: 'BJ', table: '', ratedBy: '', averageBet: bet, minutes: h * 60,
          decisionsPerHour: 80, effectiveAdvantage: 0.01, theo: 0, actualCasinoWin: 0, sd: 0, players: 3, type: PlayerType.average, at: DateTime(2026));
      final s = TripSummary.of([r(500, 2), r(450, 4), r(700, 1), r(300, 5)]);
      expect(s.weightedAvgBet, closeTo(416.67, 0.01));
    });

    test('Role permissions', () {
      const auditor = AppUser(id: 'a', name: 'A', role: AppRole.auditor);
      const pit = AppUser(id: 'b', name: 'B', role: AppRole.pitSupervisor, creditRole: CreditRole.creditManager);
      expect(auditor.can(Perm.ratePlayers), isFalse);
      expect(pit.can(Perm.ratePlayers), isTrue);
      expect(pit.canSignCredit, isFalse, reason: 'credit authority needs both a credit role and approve permission');
    });

    test('CTR record completeness requires the first 8 fields', () {
      var c = CtrReport(id: 'c', patronKey: 'p', patronLabel: 'P', aggregateLabel: 'Chip purchase', direction: 'cashIn', gamingDay: DateTime(2026), total: 12000, txIds: const ['a', 'b']);
      expect(c.complete, isFalse);
      c = c.copyWith(fields: {for (final f in Aml.ctrRequiredFields.take(8)) f: true});
      expect(c.complete, isTrue);
      expect(c.multiple, isTrue);
    });
  });

  testWidgets('First run: create admin, land on Home, open every module', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final (p, s) = await _store();
    await tester.pumpWidget(ProviderScope(overrides: [prefsProvider.overrideWithValue(p), recordStoreProvider.overrideWithValue(s)], child: const CmsApp()));
    await tester.pumpAndSettle();
    expect(find.text('Create administrator'), findsOneWidget);
    await tester.tap(find.text('Create administrator'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Thanh Admin');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Thanh Admin'), findsWidgets);
    for (final label in ['Players & ratings', 'Table games & hold', 'Credit & markers', 'Currency compliance', 'Promotions & deals', 'Staffing', 'Knowledge library', 'Settings']) {
      debugPrint('OPEN $label');
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: label);
    }
  });
  testWidgets('Phone layout: every module renders without overflow', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final (p, s) = await _store();
    await s.put('users', 'u1', const AppUser(id: 'u1', name: 'Pit Boss', role: AppRole.admin, creditRole: CreditRole.creditManager).toJson());
    await p.setString('cms.currentUserId', 'u1');
    await tester.pumpWidget(ProviderScope(overrides: [prefsProvider.overrideWithValue(p), recordStoreProvider.overrideWithValue(s)], child: const CmsApp()));
    await tester.pumpAndSettle();
    for (final label in ['Players', 'Tables', 'Credit', 'Compliance', 'Promotions', 'Staffing', 'Library', 'Settings']) {
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: label);
    }
  });
  testWidgets('Corrupted local data shows an error instead of hanging', (tester) async {
    final (p, s) = await _store({'cms.users': 'not json'});
    await tester.pumpWidget(ProviderScope(overrides: [prefsProvider.overrideWithValue(p), recordStoreProvider.overrideWithValue(s)], child: const CmsApp()));
    await tester.pumpAndSettle();
    expect(find.textContaining('could not be read'), findsOneWidget);
  });
  testWidgets('Workflow: rate a blackjack session through the form → theo saved (Ch12)', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final (p, s) = await _store();
    await s.put('users', 'u1', const AppUser(id: 'u1', name: 'Floor', role: AppRole.pitSupervisor).toJson());
    await s.put('players', 'p1', Player(id: 'p1', name: 'Jim Kilby', createdBy: 't', createdAt: DateTime(2026)).toJson());
    await p.setString('cms.currentUserId', 'u1');
    final container = ProviderContainer(overrides: [prefsProvider.overrideWithValue(p), recordStoreProvider.overrideWithValue(s)]);
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const CmsApp()));
    await tester.pumpAndSettle();
    container.read(routerProvider).go('/players/p1/rate');
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Average initial bet'), '500');
    await tester.enterText(find.widgetWithText(TextFormField, 'Time played'), '120');
    await tester.pumpAndSettle();
    expect(find.text('\$766.50'), findsOneWidget); // 500 × 2h × 105 hands (3 players) × 0.73%
    await tester.tap(find.text('Save rating'));
    await tester.pumpAndSettle();
    final saved = await s.list('ratings');
    expect(saved, hasLength(1));
    expect((saved.single['theo'] as num).toDouble(), closeTo(766.5, 0.001));
    expect(saved.single['ratedBy'], 'Floor');
  });
}
