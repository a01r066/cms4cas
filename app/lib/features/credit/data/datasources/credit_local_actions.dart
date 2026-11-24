import 'package:casino_engine/casino_engine.dart';

import '../../../../core/backend/functions_gateway.dart';
import '../../../../core/util/ids.dart';
import '../../domain/entities/credit_enums.dart';
import '../../domain/entities/credit_line.dart';
import '../../domain/entities/marker.dart';
import '../../domain/entities/signature.dart';
import '../models/credit_models.dart';
import 'credit_remote_datasource.dart';

/// Local-backend equivalents of the credit Cloud Functions in
/// firebase/functions/src/index.js. Keep both in step.
const kCreditApproverRoles = {'admin', 'casino_manager', 'credit_executive', 'marketing'};
const kMarkerRoles = {'admin', 'casino_manager', 'pit_supervisor', 'cage_cashier', 'credit_executive'};
const kWriteOffSigners = {CreditRole.president, CreditRole.vpFinance, CreditRole.creditManager, CreditRole.cageDirector};

Map<String, LocalFunction> creditLocalActions() => {
      'signCreditApplication': _sign,
      'decideCreditApplication': _decide,
      'issueMarker': _issueMarker,
      'recordMarkerPayment': _recordPayment,
      'signMarkerWriteOff': _signWriteOff,
      'writeOffMarker': _writeOff,
    };

const _apps = CreditRemoteDataSource.applications;
const _markers = CreditRemoteDataSource.markers;

Future<({CreditApplicationModel model, Map<String, dynamic> raw})> _app(LocalCall c) async {
  final id = c.str('appId');
  final j = await c.store.get(_apps, id);
  if (j == null) c.fail('not-found', 'Credit application not found.');
  return (model: CreditApplicationModel.fromJson(j), raw: j);
}

Future<MarkerModel> _marker(LocalCall c) async {
  final j = await c.store.get(_markers, c.str('markerId'));
  if (j == null) c.fail('not-found', 'Marker not found.');
  return MarkerModel.fromJson(j);
}

Future<Map<String, dynamic>> _sign(LocalCall c) async {
  final me = await c.member(roles: kCreditApproverRoles);
  final role = CreditRole.fromWire(me['creditRole'] as String?);
  if (role == null) c.fail('permission-denied', 'You have no credit signing role.');
  final a = (await _app(c)).model;
  if (a.status != CreditStatus.pendingApproval.wire) c.fail('failed-precondition', 'The application is not awaiting signatures.');
  if (a.signatures.any((s) => s.userId == c.uid)) c.fail('already-exists', 'You have already signed.');
  final sig = SignatureModel.fromEntity(Signature(userId: c.uid!, userName: (me['name'] ?? '') as String, role: role, at: DateTime.now()));
  await c.store.patch(_apps, a.id, {'signatures': [...a.signatures.map((s) => s.toJson()), sig.toJson()]});
  return {'ok': true};
}

Future<Map<String, dynamic>> _decide(LocalCall c) async {
  await c.member(roles: kCreditApproverRoles);
  final a = (await _app(c)).model.toEntity();
  final decision = c.str('decision');
  if (decision == 'decline') {
    final reason = c.str('reason');
    if (a.status != CreditStatus.draft && a.status != CreditStatus.pendingApproval) c.fail('failed-precondition', 'Already decided.');
    await c.store.patch(_apps, a.id, {'status': CreditStatus.declined.wire, 'declineReason': reason, 'decidedAt': DateTime.now().toIso8601String()});
    return {'ok': true};
  }
  if (decision != 'approve') c.fail('invalid-argument', 'Unknown decision.');
  if (a.status != CreditStatus.pendingApproval) c.fail('failed-precondition', 'The application is not awaiting signatures.');
  if (a.outcome == null || !a.outcome!.allowsApproval) c.fail('failed-precondition', 'The assessment does not allow approval.');
  final check = a.signatureCheck;
  if (!check.satisfied) c.fail('failed-precondition', 'Still needed: ${check.missing}');
  if (a.outcome == CreditOutcome.referToCreditManager && !a.hasCreditManagerSignature) {
    c.fail('failed-precondition', 'A Credit Manager signature is required for a referred application.');
  }
  await c.store.patch(_apps, a.id, {'status': CreditStatus.approved.wire, 'decidedAt': DateTime.now().toIso8601String()});
  return {'ok': true};
}

Future<Map<String, dynamic>> _issueMarker(LocalCall c) async {
  final me = await c.member(roles: kMarkerRoles);
  final playerId = c.str('playerId');
  final number = c.str('number');
  final table = c.str('table');
  final amount = c.number('amount');
  if (amount <= 0) c.fail('invalid-argument', 'Enter an amount.');
  final apps = (await c.store.list(_apps)).map((j) => CreditApplicationModel.fromJson(j).toEntity()).toList();
  final markers = (await c.store.list(_markers)).map((j) => MarkerModel.fromJson(j).toEntity()).toList();
  final line = availableCredit(apps, markers, playerId);
  if (line.line <= 0) c.fail('failed-precondition', 'The player has no approved credit line.');
  if (amount > line.available + 0.001) c.fail('failed-precondition', 'Exceeds available credit.');
  final m = Marker(id: newId(), playerId: playerId, number: number, table: table, issuedBy: (me['name'] ?? '') as String, amount: amount, issuedAt: DateTime.now());
  await c.store.put(_markers, m.id, MarkerModel.fromEntity(m).toJson());
  return {'markerId': m.id};
}

Future<Map<String, dynamic>> _recordPayment(LocalCall c) async {
  final me = await c.member(roles: kMarkerRoles);
  final m = (await _marker(c)).toEntity();
  final amount = c.number('amount');
  final method = c.str('method');
  if (m.status != MarkerStatus.open) c.fail('failed-precondition', 'The marker is not open.');
  if (amount <= 0 || amount > m.balance + 0.001) c.fail('invalid-argument', 'Enter an amount between \$0 and the balance.');
  final pays = [...m.payments, MarkerPayment(amount: amount, method: method, recordedBy: (me['name'] ?? '') as String, at: DateTime.now())];
  final paidAll = pays.fold<double>(0, (s, p) => s + p.amount) >= m.amount - 0.001;
  final upd = m.copyWith(payments: pays, status: paidAll ? MarkerStatus.paid : MarkerStatus.open);
  await c.store.patch(_markers, m.id, {
    'payments': MarkerModel.fromEntity(upd).toJson()['payments'],
    'status': upd.status.wire,
  });
  return {'ok': true};
}

Future<Map<String, dynamic>> _signWriteOff(LocalCall c) async {
  final me = await c.member(roles: {...kMarkerRoles, ...kCreditApproverRoles});
  final role = CreditRole.fromWire(me['creditRole'] as String?);
  if (role == null || !kWriteOffSigners.contains(role)) {
    c.fail('permission-denied', 'Write-offs are signed by the President/GM, VP Finance, Credit Manager or Director of Cage.');
  }
  final m = (await _marker(c)).toEntity();
  if (m.status != MarkerStatus.open) c.fail('failed-precondition', 'The marker is not open.');
  if (m.writeOffSignatures.any((s) => s.userId == c.uid)) c.fail('already-exists', 'You have already signed.');
  final sig = Signature(userId: c.uid!, userName: (me['name'] ?? '') as String, role: role, at: DateTime.now());
  await c.store.patch(_markers, m.id, {
    'writeOffSignatures': [...m.writeOffSignatures.map((s) => SignatureModel.fromEntity(s).toJson()), SignatureModel.fromEntity(sig).toJson()],
    'writeOffReason': c.str('reason', required: false),
  });
  return {'ok': true};
}

Future<Map<String, dynamic>> _writeOff(LocalCall c) async {
  await c.member(roles: {...kMarkerRoles, ...kCreditApproverRoles});
  final m = (await _marker(c)).toEntity();
  final reason = c.str('reason');
  if (m.status != MarkerStatus.open || m.balance <= 0) c.fail('failed-precondition', 'Nothing to write off.');
  if (!Credit.writeOffApproved(m.writeOffSignatures.map((s) => s.role).toList())) {
    c.fail('failed-precondition', 'Two authorized signatures are required before writing off.');
  }
  await c.store.patch(_markers, m.id, {
    'status': (m.paid > 0 ? MarkerStatus.settled : MarkerStatus.writtenOff).wire,
    'writeOffAmount': m.balance,
    'writeOffReason': reason,
  });
  return {'ok': true};
}
