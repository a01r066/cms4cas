import 'package:casino_engine/casino_engine.dart';
import 'package:cms_kiss/core/typedefs/typedefs.dart';
import 'package:cms_kiss/features/auth/data/models/access_request_model.dart';
import 'package:cms_kiss/features/auth/data/models/app_user_model.dart';
import 'package:cms_kiss/features/compliance/data/models/compliance_models.dart';
import 'package:cms_kiss/features/credit/data/models/credit_models.dart';
import 'package:cms_kiss/features/credit/domain/entities/credit_enums.dart';
import 'package:cms_kiss/features/demo_data/data/demo_data_generator.dart';
import 'package:cms_kiss/features/demo_data/presentation/providers/demo_data_notifier.dart';
import 'package:cms_kiss/features/demo_data/presentation/providers/demo_data_providers.dart';
import 'package:cms_kiss/features/demo_data/presentation/widgets/demo_data_card.dart';
import 'package:cms_kiss/features/players/data/models/player_model.dart';
import 'package:cms_kiss/features/players/data/models/rating_record_model.dart';
import 'package:cms_kiss/features/settings/domain/entities/app_settings.dart';
import 'package:cms_kiss/features/tables/data/models/table_models.dart';
import 'package:cms_kiss/shared/providers/backend_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  final now = DateTime(2026, 11, 24, 15, 30);
  final data = DemoData.build(now: now);
  List<Json> docs(String c) => data[c]!.values.toList();

  group('DemoData generator', () {
    test('covers every collection, ids are prefixed and keys match ids', () {
      for (final c in DemoData.collections) {
        expect(data[c], isNotEmpty, reason: c);
        data[c]!.forEach((id, j) {
          expect(id.startsWith(DemoData.prefix), isTrue, reason: '$c/$id');
          expect(j['id'] ?? j['uid'], id, reason: '$c/$id');
        });
      }
    });

    test('is deterministic for the same clock and seed', () {
      expect(DemoData.build(now: now).toString(), data.toString());
    });

    test('every record parses through its model', () {
      final parsers = <String, Object Function(Json)>{
        'users': (j) => AppUserModel.fromJson(j).toEntity(),
        'players': (j) => PlayerModel.fromJson(j).toEntity(),
        'ratings': (j) => RatingRecordModel.fromJson(j).toEntity(),
        'tables': (j) => TableDefModel.fromJson(j).toEntity(),
        'table_shifts': (j) => TableShiftModel.fromJson(j).toEntity(),
        'hits': (j) => HitRecordModel.fromJson(j).toEntity(),
        'credit_applications': (j) => CreditApplicationModel.fromJson(j).toEntity(),
        'markers': (j) => MarkerModel.fromJson(j).toEntity(),
        'cash_transactions': (j) => CashTxModel.fromJson(j).toEntity(),
        'ctr_reports': (j) => CtrReportModel.fromJson(j).toEntity(),
        'barred_patrons': (j) => BarredPatronModel.fromJson(j).toEntity(),
        'sar_cases': (j) => SarCaseModel.fromJson(j).toEntity(),
        'access_requests': (j) => AccessRequestModel.fromJson(j).toEntity(),
      };
      expect(parsers.keys.toSet(), DemoData.collections.toSet());
      for (final c in DemoData.collections) {
        for (final j in docs(c)) {
          expect(() => parsers[c]!(j), returnsNormally, reason: '$c/${j['id']}');
        }
      }
    });

    test('includes the book roulette rating: theo \$1,065.15 (Ch12 p.221)', () {
      final r = docs('ratings').map((j) => RatingRecordModel.fromJson(j).toEntity());
      expect(r.any((x) => x.gameId == 'roulette' && x.averageBet == 150 && x.minutes == 135 && (x.theo - 1065.15).abs() < 0.01), isTrue);
    });

    test('table shifts are valid and BJ-04 runs below its hold objective', () {
      final shifts = docs('table_shifts').map((j) => TableShiftModel.fromJson(j).toEntity()).toList();
      for (final s in shifts) {
        expect(s.input.validate(), isEmpty, reason: s.id);
      }
      final bj04 = shifts.where((s) => s.tableId == 'demo-table-bj-04' && now.difference(s.gamingDay).inDays <= 6).map((s) => s.result);
      final hold = bj04.fold<double>(0, (a, r) => a + r.win) / bj04.fold<double>(0, (a, r) => a + r.drop);
      expect(hold, lessThan(0.14 - 0.03));
    });

    test('approved credit lines meet Table 6.2; pending and referred ones do not yet', () {
      final apps = docs('credit_applications').map((j) => CreditApplicationModel.fromJson(j).toEntity()).toList();
      final approved = apps.where((a) => a.status == CreditStatus.approved).toList();
      expect(approved, hasLength(3));
      for (final a in approved) {
        expect(a.signatureCheck.satisfied, isTrue, reason: a.id);
        expect(a.outcome?.allowsApproval, isTrue, reason: a.id);
      }
      final pending = apps.where((a) => a.status == CreditStatus.pendingApproval).toList();
      expect(pending, hasLength(2));
      expect(pending.every((a) => !a.canApprove), isTrue);
      expect(pending.any((a) => a.outcome == CreditOutcome.referToCreditManager), isTrue);
      expect(apps.where((a) => a.status == CreditStatus.declined), hasLength(1));
      expect(apps.where((a) => a.status == CreditStatus.draft), hasLength(1));
    });

    test('markers span the aging buckets; the written-off one has two authorised signatures', () {
      final markers = docs('markers').map((j) => MarkerModel.fromJson(j).toEntity()).toList();
      final ages = markers.where((m) => m.status == MarkerStatus.open).map((m) => now.difference(m.issuedAt).inDays).toList();
      expect(ages.any((d) => d <= 30), isTrue);
      expect(ages.any((d) => d > 30 && d <= 60), isTrue);
      expect(ages.any((d) => d > 60 && d <= 90), isTrue);
      expect(ages.any((d) => d > 90), isTrue);
      final settled = markers.singleWhere((m) => m.status == MarkerStatus.settled);
      expect(Credit.writeOffApproved(settled.writeOffSignatures.map((s) => s.role).toList()), isTrue);
    });

    test('cash transactions produce reportable aggregates matching the CTRs', () {
      const settings = AppSettings();
      final txs = docs('cash_transactions').map((j) => CashTxModel.fromJson(j).toEntity().tx).toList();
      final aggs = Aml.aggregate(txs, settings.aml).where((a) => a.reportable).toList();
      expect(aggs.map((a) => a.patronKey), containsAll(['demo-player-1', 'demo-player-2', 'desc:tall man, red tie, bj-03']));
      // Chen Wei's purchases today are reportable with no CTR started (Home alert).
      final ctrs = docs('ctr_reports').map((j) => CtrReportModel.fromJson(j).toEntity()).toList();
      expect(ctrs.map((c) => c.patronKey), isNot(contains('demo-player-2')));
      for (final c in ctrs) {
        expect(c.total, greaterThan(settings.aml.ctrThreshold));
      }
    });
  });

  group('DemoDataNotifier (local backend)', () {
    Future<ProviderContainer> admin() async {
      final c = await localContainer();
      await signInAs(c, 'u-owner', {'name': 'Owner', 'role': 'admin', 'creditRole': 'president'});
      return c;
    }

    test('loads every collection, then removes it but keeps the signed-in admin', () async {
      final c = await admin();
      final loaded = await c.read(demoDataNotifierProvider.notifier).load();
      expect(loaded.isRight(), isTrue);
      for (final col in DemoData.collections) {
        expect((await store(c).list(col)).any((j) => ((j['id'] ?? j['uid']) as String).startsWith('demo-')), isTrue, reason: col);
      }
      expect(await store(c).get('users', 'demo-credit'), isNotNull);

      final removed = await c.read(demoDataNotifierProvider.notifier).remove();
      expect(removed.getOrElse(() => 0), loaded.getOrElse(() => 0));
      for (final col in DemoData.collections) {
        expect((await store(c).list(col)).any((j) => ((j['id'] ?? j['uid']) as String).startsWith('demo-')), isFalse, reason: col);
      }
      expect(await store(c).get('users', 'u-owner'), isNotNull);
    });

    test('non-admins are refused', () async {
      final c = await localContainer();
      await signInAs(c, 'u-pit', {'name': 'Pit', 'role': 'pit_supervisor'});
      final r = await c.read(demoDataNotifierProvider.notifier).load();
      expect(r.fold((f) => f.code, (_) => ''), 'permission-denied');
      expect(await store(c).list('players'), isEmpty);
    });

    test('is not available on the Firebase backend', () async {
      final c = ProviderContainer(overrides: await localOverrides(const {}, Backend.firebase));
      expect(c.read(demoDataAvailableProvider), isFalse);
    });
  });

  testWidgets('Settings card loads demo data', (tester) async {
    final overrides = await localOverrides({
      'cms.currentUserId': 'u-owner',
      'cms.users': '{"u-owner":{"id":"u-owner","name":"Owner","role":"admin"}}',
    });
    final c = ProviderContainer(overrides: overrides);
    addTearDown(c.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: c,
      child: const MaterialApp(home: Scaffold(body: SingleChildScrollView(child: DemoDataCard()))),
    ));
    Future<void> flush() async {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pumpAndSettle();
    }

    await flush();
    await flush();
    expect(find.text('No demo data on this device.'), findsOneWidget);
    await tester.tap(find.byKey(const Key('demo-load')));
    await flush();
    await flush();
    expect(find.text('Demo data is loaded.'), findsOneWidget);
  });
}
