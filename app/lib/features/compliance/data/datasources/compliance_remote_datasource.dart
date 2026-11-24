import '../../../../core/backend/functions_gateway.dart';
import '../../../../core/storage/record_store.dart';
import '../models/compliance_models.dart';

class ComplianceRemoteDataSource {
  ComplianceRemoteDataSource(this._store, this._functions);

  final RecordStore _store;
  final FunctionsGateway _functions;

  static const cashTx = 'cash_transactions';
  static const ctrs = 'ctr_reports';
  static const barred = 'barred_patrons';
  static const sars = 'sar_cases';

  Stream<List<CashTxModel>> watchCashTx() => _store.watch(cashTx).map((l) => l.map(CashTxModel.fromJson).toList());

  /// Append-only (rules deny update/delete).
  Future<void> addCashTx(CashTxModel m) => _store.put(cashTx, m.id, m.toJson());

  Stream<List<CtrReportModel>> watchCtrs() => _store.watch(ctrs).map((l) => l.map(CtrReportModel.fromJson).toList());
  Future<void> createCtr(CtrReportModel m) => _store.put(ctrs, m.id, m.toJson());

  /// Draft only (rules).
  Future<void> setCtrFields(String ctrId, Map<String, bool> fields) => _store.patch(ctrs, ctrId, {'fields': fields});

  /// prepared / reviewed / filed — signer stamped server-side; reviewer ≠ preparer.
  Future<void> advanceCtr(String ctrId, String to) => _functions.call('advanceCtr', {'ctrId': ctrId, 'to': to});

  Stream<List<BarredPatronModel>> watchBarred() => _store.watch(barred).map((l) => l.map(BarredPatronModel.fromJson).toList());
  Future<void> saveBarred(BarredPatronModel m) => _store.put(barred, m.id, m.toJson());

  Stream<List<SarCaseModel>> watchSars() => _store.watch(sars).map((l) => l.map(SarCaseModel.fromJson).toList());
  Future<void> saveSar(SarCaseModel m) => _store.put(sars, m.id, m.toJson());
}
