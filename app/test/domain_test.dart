import 'package:casino_engine/casino_engine.dart';
import 'package:cms_kiss/features/auth/domain/entities/app_role.dart';
import 'package:cms_kiss/features/auth/domain/entities/app_user.dart';
import 'package:cms_kiss/features/compliance/domain/entities/compliance_entities.dart';
import 'package:cms_kiss/features/credit/domain/entities/credit_application.dart';
import 'package:cms_kiss/features/credit/domain/entities/credit_enums.dart';
import 'package:cms_kiss/features/credit/domain/entities/credit_line.dart';
import 'package:cms_kiss/features/credit/domain/entities/marker.dart';
import 'package:cms_kiss/features/credit/domain/entities/signature.dart';
import 'package:cms_kiss/features/players/domain/entities/rating_record.dart';
import 'package:cms_kiss/features/players/domain/entities/trip_summary.dart';
import 'package:flutter_test/flutter_test.dart';

Signature sig(CreditRole r) => Signature(userId: r.wire, userName: r.label, role: r, at: DateTime(2026));

void main() {
  test('Available credit = latest approved line − open markers', () {
    final apps = [
      CreditApplication(id: 'a', playerId: 'p', createdBy: '', lineType: LineType.permanent, amount: 10000, status: CreditStatus.approved, createdAt: DateTime(2026), decidedAt: DateTime(2026)),
      CreditApplication(id: 'b', playerId: 'p', createdBy: '', lineType: LineType.temporary, amount: 12500, status: CreditStatus.approved, createdAt: DateTime(2026, 2), decidedAt: DateTime(2026, 2)),
      CreditApplication(id: 'c', playerId: 'p', createdBy: '', lineType: LineType.permanent, amount: 99999, status: CreditStatus.declined, createdAt: DateTime(2026, 3)),
    ];
    final markers = [
      Marker(id: 'm', playerId: 'p', number: '1', table: 'BJ1', issuedBy: '', amount: 5000, issuedAt: DateTime(2026),
          payments: [MarkerPayment(amount: 1000, method: 'Check', recordedBy: '', at: DateTime(2026))]),
    ];
    final a = availableCredit(apps, markers, 'p');
    expect(a.line, 12500);
    expect(a.outstanding, 4000);
    expect(a.available, 8500);
  });

  test('Trip summary uses time-weighted average bet (Ch19 p.364)', () {
    RatingRecord r(double bet, double h) => RatingRecord(
        id: '$bet', playerId: 'p', gameId: 'blackjack', gameName: 'BJ', ratedBy: '', averageBet: bet, minutes: h * 60,
        decisionsPerHour: 80, effectiveAdvantage: 0.01, theo: 0, sd: 0, players: 3, type: PlayerType.average, at: DateTime(2026));
    final s = TripSummary.of([r(500, 2), r(450, 4), r(700, 1), r(300, 5)]);
    expect(s.weightedAvgBet, closeTo(416.67, 0.01));
  });

  test('Role permissions', () {
    const auditor = AppUser(id: 'a', name: 'A', role: AppRole.auditor);
    const pit = AppUser(id: 'b', name: 'B', role: AppRole.pitSupervisor, creditRole: CreditRole.creditManager);
    expect(auditor.can(Perm.ratePlayers), isFalse);
    expect(pit.can(Perm.ratePlayers), isTrue);
    expect(pit.canSignCredit, isFalse, reason: 'credit authority needs both a credit role and approve permission');
    expect(AppRole.fromWire('root'), AppRole.auditor, reason: 'unknown role → least privilege');
  });

  test('Referred application needs a Credit Manager signature to be approvable', () {
    var a = CreditApplication(
        id: 'a', playerId: 'p', createdBy: '', lineType: LineType.temporary, amount: 8000, status: CreditStatus.pendingApproval,
        createdAt: DateTime(2026), outcome: CreditOutcome.referToCreditManager, signatures: [sig(CreditRole.host)]);
    expect(a.signatureCheck.satisfied, isTrue);
    expect(a.canApprove, isFalse);
    a = a.copyWith(signatures: [...a.signatures, sig(CreditRole.creditManager)]);
    expect(a.canApprove, isTrue);
  });

  test('CTR completeness requires the first 8 fields', () {
    var c = CtrReport(id: 'c', patronKey: 'p', patronLabel: 'P', aggregateLabel: 'Chip purchase', direction: 'cashIn', gamingDay: DateTime(2026), total: 12000, txIds: const ['a', 'b']);
    expect(c.complete, isFalse);
    c = c.copyWith(fields: {for (final f in Aml.ctrRequiredFields.take(8)) f: true});
    expect(c.complete, isTrue);
    expect(c.multiple, isTrue);
  });
}
