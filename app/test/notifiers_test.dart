import 'package:casino_engine/casino_engine.dart';
import 'package:cms_kiss/features/auth/domain/entities/app_role.dart';
import 'package:cms_kiss/features/auth/domain/entities/app_user.dart';
import 'package:cms_kiss/features/auth/presentation/providers/auth_notifier.dart';
import 'package:cms_kiss/features/auth/presentation/providers/auth_providers.dart';
import 'package:cms_kiss/features/compliance/domain/entities/compliance_entities.dart';
import 'package:cms_kiss/features/compliance/presentation/providers/compliance_notifier.dart';
import 'package:cms_kiss/features/compliance/presentation/providers/compliance_providers.dart';
import 'package:cms_kiss/features/credit/domain/entities/credit_enums.dart';
import 'package:cms_kiss/features/credit/presentation/providers/credit_notifier.dart';
import 'package:cms_kiss/features/credit/presentation/providers/credit_providers.dart';
import 'package:cms_kiss/features/tables/presentation/providers/tables_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

const _cleanAnswers = {
  'applicationComplete': true, 'applicationLegible': true, 'idCopied': true, 'gamingReportObtained': true,
  'consumerReportObtained': true, 'consumerReportClear': true, 'bankCheckObtained': true, 'canSignAlone': true,
  'accountOpen6Months': true, 'averageBalanceSupports': true,
};

void main() {
  group('Auth: setUserRole action', () {
    test('first user must be admin; afterwards only an admin assigns roles', () async {
      final c = await localContainer();
      addTearDown(c.dispose);
      final auth = c.read(authNotifierProvider.notifier);

      final notAdmin = await auth.saveUser(const AppUser(id: '', name: 'Eve', role: AppRole.pitSupervisor), firstAdmin: true);
      expect(notAdmin.isLeft(), isTrue);

      final first = await auth.saveUser(const AppUser(id: '', name: 'Thanh', role: AppRole.admin), firstAdmin: true);
      expect(first.isRight(), isTrue);
      await settle();
      expect(c.read(currentUserValueProvider)?.name, 'Thanh', reason: 'first admin is signed in');

      final added = await auth.saveUser(const AppUser(id: '', name: 'Floor', role: AppRole.pitSupervisor));
      expect(added.isRight(), isTrue);
      final floorId = added.getOrElse(() => throw StateError('')).id;

      await auth.signInAs(floorId);
      await settle();
      final escalate = await auth.saveUser(const AppUser(id: '', name: 'Mallory', role: AppRole.admin));
      expect(escalate.fold((f) => f.code, (_) => ''), 'permission-denied');
    });
  });

  group('Credit workflow (Fig 6.4 → Table 6.2 → markers → write-off)', () {
    test('end to end through the privileged actions', () async {
      final c = await localContainer();
      addTearDown(c.dispose);
      keepAlive(c, [creditAppsProvider, markersProvider]);
      final n = c.read(creditNotifierProvider.notifier);

      await signInAs(c, 'cm', {'name': 'Credit Mgr', 'role': 'credit_executive', 'creditRole': 'credit_manager'});
      final app = (await n.createApplication(playerId: 'p1', lineType: LineType.permanent, amount: 20000))
          .getOrElse(() => throw StateError('create'));
      await settle();

      // Cannot submit before assessment; assessment of a clean file → ready for decision.
      expect((await n.submitForSignatures(app)).isLeft(), isTrue);
      final assessed = await n.runAssessment(app, _cleanAnswers);
      expect(assessed.getOrElse(() => throw StateError('')).outcome, CreditOutcome.readyForDecision);
      await settle();
      expect((await n.submitForSignatures(c.read(creditAppByIdProvider(app.id))!)).isRight(), isTrue);
      await settle();

      // One signature is not enough for a permanent $20k line.
      expect((await n.sign(c.read(creditAppByIdProvider(app.id))!)).isRight(), isTrue);
      await settle();
      expect((await n.sign(c.read(creditAppByIdProvider(app.id))!)).isLeft(), isTrue, reason: 'cannot sign twice');
      expect((await n.approve(c.read(creditAppByIdProvider(app.id))!)).isLeft(), isTrue);

      await signInAs(c, 'host', {'name': 'Host', 'role': 'marketing', 'creditRole': 'host'});
      await n.sign(c.read(creditAppByIdProvider(app.id))!);
      await settle();
      final approved = await n.approve(c.read(creditAppByIdProvider(app.id))!);
      expect(approved.isRight(), isTrue, reason: approved.fold((f) => f.displayMessage, (_) => ''));
      await settle();
      expect(c.read(creditAppByIdProvider(app.id))!.status, CreditStatus.approved);

      // Markers: capped at available credit, server-side too.
      await signInAs(c, 'pit', {'name': 'Pit', 'role': 'pit_supervisor'});
      final line = c.read(availableCreditProvider('p1'));
      expect(line.available, 20000);
      final tooMuch = await n.issueMarker(playerId: 'p1', number: 'M1', table: 'BJ1', amount: 25000, line: (line: 30000, outstanding: 0, available: 30000));
      expect(tooMuch.fold((f) => f.displayMessage, (_) => ''), 'Exceeds available credit.', reason: 'server re-checks even if the client is wrong');
      expect((await n.issueMarker(playerId: 'p1', number: 'M1', table: 'BJ1', amount: 15000, line: line)).isRight(), isTrue);
      await settle();
      expect(c.read(availableCreditProvider('p1')).available, 5000);

      final marker = c.read(markersProvider).value!.single;
      expect((await n.recordPayment(marker, 5000, 'Check')).isRight(), isTrue);
      await settle();
      final open = c.read(markersProvider).value!.single;
      expect(open.balance, 10000);

      // Write-off: two of President/GM, VP Finance, Credit Manager, Director of Cage (p.105).
      expect((await n.writeOff(open, 'Dispute')).isLeft(), isTrue);
      expect((await n.signWriteOff(open, 'Dispute')).isLeft(), isTrue, reason: 'pit supervisor has no write-off authority');
      await signInAs(c, 'cm', {'name': 'Credit Mgr', 'role': 'credit_executive', 'creditRole': 'credit_manager'});
      await n.signWriteOff(c.read(markersProvider).value!.single, 'Dispute');
      await signInAs(c, 'cage', {'name': 'Cage Dir', 'role': 'cage_cashier', 'creditRole': 'cage_director'});
      await n.signWriteOff(c.read(markersProvider).value!.single, 'Dispute');
      await settle();
      final wo = await n.writeOff(c.read(markersProvider).value!.single, 'Dispute');
      expect(wo.isRight(), isTrue, reason: wo.fold((f) => f.displayMessage, (_) => ''));
      await settle();
      final done = c.read(markersProvider).value!.single;
      expect(done.status, MarkerStatus.settled);
      expect(done.writeOffAmount, 10000);
    });
  });

  group('CTR workflow (Ch5)', () {
    test('prepared needs the fields; reviewer must differ from preparer', () async {
      final c = await localContainer();
      addTearDown(c.dispose);
      keepAlive(c, [ctrProvider, cashTxProvider]);
      final n = c.read(complianceNotifierProvider.notifier);
      await signInAs(c, 'cage', {'name': 'Cashier', 'role': 'cage_cashier'});

      await n.recordCashTx(description: 'Tall man, red tie', area: 'Cage', type: CashTxType.chipPurchase, amount: 6000);
      await n.recordCashTx(description: 'Tall man, red tie', area: 'Cage', type: CashTxType.chipPurchase, amount: 5000);
      await settle();
      final agg = Aml.aggregate(c.read(cashTxProvider).value!.map((t) => t.tx).toList(), AmlProfile.bookNevada2003)
          .where((a) => a.reportable)
          .single;
      expect(agg.total, 11000);
      await n.startCtr(agg, 'Tall man, red tie');
      await settle();
      var ctr = c.read(ctrProvider).value!.single;

      expect((await n.advanceCtr(ctr, CtrStatus.prepared)).isLeft(), isTrue, reason: 'fields incomplete');
      for (final f in Aml.ctrRequiredFields.take(8)) {
        await n.setCtrField(c.read(ctrProvider).value!.single, f, true);
        await settle();
      }
      ctr = c.read(ctrProvider).value!.single;
      expect((await n.advanceCtr(ctr, CtrStatus.prepared)).isRight(), isTrue);
      await settle();

      await signInAs(c, 'cage', {'name': 'Cashier', 'role': 'compliance_officer'});
      final self = await n.advanceCtr(c.read(ctrProvider).value!.single, CtrStatus.reviewed);
      expect(self.fold((f) => f.code, (_) => ''), 'failed-precondition');

      await signInAs(c, 'co', {'name': 'Compliance', 'role': 'compliance_officer'});
      expect((await n.advanceCtr(c.read(ctrProvider).value!.single, CtrStatus.reviewed)).isRight(), isTrue);
      await settle();
      expect((await n.advanceCtr(c.read(ctrProvider).value!.single, CtrStatus.filed)).isRight(), isTrue);
      await settle();
      final filed = c.read(ctrProvider).value!.single;
      expect(filed.status, CtrStatus.filed);
      expect(filed.preparedBy, 'Cashier');
      expect(filed.reviewedBy, 'Compliance');
    });
  });

  group('Tables', () {
    test('hits below the threshold are not excluded from hold', () async {
      final c = await localContainer();
      addTearDown(c.dispose);
      await signInAs(c, 'pit', {'name': 'Pit', 'role': 'pit_supervisor'});
      final n = c.read(tablesNotifierProvider.notifier);
      final small = await n.recordHit(tableId: 't', playerLabel: 'X', gamingDay: DateTime(2026), playerDrop: 5000, casinoResult: -4000, threshold: 10000);
      expect(small.isLeft(), isTrue);
      final big = await n.recordHit(tableId: 't', playerLabel: 'X', gamingDay: DateTime(2026), playerDrop: 50000, casinoResult: -40000, threshold: 10000);
      expect(big.isRight(), isTrue);
      expect(await store(c).list('hits'), hasLength(1));
    });
  });

  test('Signed-out users see no data and no SAR permission errors', () async {
    final c = await localContainer();
    addTearDown(c.dispose);
    keepAlive(c, [sarProvider, creditAppsProvider]);
    await store(c).put('sar_cases', 's', {'id': 's', 'detectedAt': '2026-01-01T00:00:00.000'});
    await settle();
    expect(c.read(sarProvider).value, isEmpty);
    await signInAs(c, 'pit', {'name': 'Pit', 'role': 'pit_supervisor'});
    await settle();
    expect(c.read(sarProvider).value, isEmpty, reason: 'pit supervisors cannot read SAR cases');
    await signInAs(c, 'co', {'name': 'CO', 'role': 'compliance_officer'});
    await settle();
    expect(c.read(sarProvider).value, hasLength(1));
  });
}
