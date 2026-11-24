import '../../../../core/backend/functions_gateway.dart';
import '../../../../core/storage/record_store.dart';
import '../models/credit_models.dart';

/// Applications are created and assessed by the client; every signature,
/// decision and money movement goes through a privileged action.
class CreditRemoteDataSource {
  CreditRemoteDataSource(this._store, this._functions);

  final RecordStore _store;
  final FunctionsGateway _functions;

  static const applications = 'credit_applications';
  static const markers = 'markers';

  Stream<List<CreditApplicationModel>> watchApplications() =>
      _store.watch(applications).map((l) => l.map(CreditApplicationModel.fromJson).toList());

  Stream<List<MarkerModel>> watchMarkers() => _store.watch(markers).map((l) => l.map(MarkerModel.fromJson).toList());

  Future<void> createApplication(CreditApplicationModel m) => _store.put(applications, m.id, m.toJson());

  /// Draft only (rules): answers + Fig 6.4 outcome.
  Future<void> saveAssessment(String appId, Map<String, bool> answers, String outcome, List<String> referrals) =>
      _store.patch(applications, appId, {'answers': answers, 'outcome': outcome, 'referrals': referrals});

  /// Draft → awaiting signatures (rules check the outcome allows it).
  Future<void> submitForSignatures(String appId) => _store.patch(applications, appId, {'status': 'pending_approval'});

  Future<void> sign(String appId) => _functions.call('signCreditApplication', {'appId': appId});

  Future<void> decide(String appId, {required bool approve, String reason = ''}) =>
      _functions.call('decideCreditApplication', {'appId': appId, 'decision': approve ? 'approve' : 'decline', 'reason': reason});

  Future<String> issueMarker({required String playerId, required String number, required String table, required double amount}) async {
    final r = await _functions.call('issueMarker', {'playerId': playerId, 'number': number, 'table': table, 'amount': amount});
    return (r['markerId'] ?? '') as String;
  }

  Future<void> recordPayment(String markerId, double amount, String method) =>
      _functions.call('recordMarkerPayment', {'markerId': markerId, 'amount': amount, 'method': method});

  Future<void> signWriteOff(String markerId, String reason) =>
      _functions.call('signMarkerWriteOff', {'markerId': markerId, 'reason': reason});

  Future<void> writeOff(String markerId, String reason) =>
      _functions.call('writeOffMarker', {'markerId': markerId, 'reason': reason});

  /// The only marker field the client may change (rules).
  Future<void> saveCollectionNote(String markerId, String note) => _store.patch(markers, markerId, {'collectionNote': note});
}
