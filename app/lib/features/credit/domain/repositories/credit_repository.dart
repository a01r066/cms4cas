import '../../../../core/typedefs/typedefs.dart';
import '../entities/credit_application.dart';
import '../entities/marker.dart';

abstract interface class CreditRepository {
  Stream<List<CreditApplication>> watchApplications();
  Stream<List<Marker>> watchMarkers();

  ResultFuture<CreditApplication> createApplication(CreditApplication app);
  ResultVoid saveAssessment(CreditApplication app);
  ResultVoid submitForSignatures(String appId);
  ResultVoid sign(String appId);
  ResultVoid approve(String appId);
  ResultVoid decline(String appId, String reason);

  ResultFuture<String> issueMarker({required String playerId, required String number, required String table, required double amount});
  ResultVoid recordPayment(String markerId, double amount, String method);
  ResultVoid signWriteOff(String markerId, String reason);
  ResultVoid writeOff(String markerId, String reason);
  ResultVoid saveCollectionNote(String markerId, String note);
}
