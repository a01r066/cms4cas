import '../../../../core/typedefs/typedefs.dart';
import '../entities/compliance_entities.dart';

abstract interface class ComplianceRepository {
  Stream<List<CashTxRecord>> watchCashTx();
  ResultFuture<CashTxRecord> addCashTx(CashTxRecord tx);

  Stream<List<CtrReport>> watchCtrs();
  ResultFuture<CtrReport> createCtr(CtrReport report);
  ResultVoid setCtrFields(String ctrId, Map<String, bool> fields);
  ResultVoid advanceCtr(String ctrId, CtrStatus to);

  Stream<List<BarredPatron>> watchBarred();
  ResultFuture<BarredPatron> saveBarred(BarredPatron b);

  Stream<List<SarCase>> watchSars();
  ResultFuture<SarCase> saveSar(SarCase s);
}
