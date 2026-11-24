import '../../../../core/backend/functions_gateway.dart';
import '../../domain/entities/compliance_entities.dart';
import '../models/compliance_models.dart';
import 'compliance_remote_datasource.dart';

/// Local equivalent of the `advanceCtr` Cloud Function. Keep in step with index.js.
const kCtrPrepareRoles = {'admin', 'casino_manager', 'pit_supervisor', 'cage_cashier', 'compliance_officer'};
const kCtrReviewRoles = {'admin', 'casino_manager', 'compliance_officer'};

Map<String, LocalFunction> complianceLocalActions() => {'advanceCtr': _advanceCtr};

Future<Map<String, dynamic>> _advanceCtr(LocalCall c) async {
  final to = CtrStatus.fromWire(c.str('to'));
  final me = await c.member(roles: to == CtrStatus.prepared ? kCtrPrepareRoles : kCtrReviewRoles);
  final j = await c.store.get(ComplianceRemoteDataSource.ctrs, c.str('ctrId'));
  if (j == null) c.fail('not-found', 'Report not found.');
  final r = CtrReportModel.fromJson(j).toEntity();
  final name = (me['name'] ?? '') as String;
  final now = DateTime.now().toIso8601String();
  final Map<String, dynamic> patch;
  switch (to) {
    case CtrStatus.prepared:
      if (r.status != CtrStatus.draft) c.fail('failed-precondition', 'Only a draft can be prepared.');
      if (!r.complete) c.fail('failed-precondition', 'Complete the required fields first.');
      patch = {'status': to.wire, 'preparedBy': name, 'preparedById': c.uid};
    case CtrStatus.reviewed:
      if (r.status != CtrStatus.prepared) c.fail('failed-precondition', 'The report has not been prepared.');
      if (r.preparedById == c.uid) c.fail('failed-precondition', 'The reviewer must be a different employee from the preparer.');
      patch = {'status': to.wire, 'reviewedBy': name, 'reviewedById': c.uid};
    case CtrStatus.filed:
      if (r.status != CtrStatus.reviewed) c.fail('failed-precondition', 'The report has not been reviewed.');
      patch = {'status': to.wire, 'filedAt': now};
    case CtrStatus.draft:
      c.fail('invalid-argument', 'A report cannot go back to draft.');
  }
  await c.store.patch(ComplianceRemoteDataSource.ctrs, r.id, patch);
  return {'ok': true};
}
