import 'package:casino_engine/casino_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/repository.dart';
import '../../../shared/providers.dart';

DateTime? _dtn(Object? v) => v is String ? DateTime.parse(v) : null;
double _d(Object? v) => v is num ? v.toDouble() : 0;

enum CreditStatus {
  draft('draft', 'Draft'),
  pendingApproval('pending_approval', 'Awaiting signatures'),
  approved('approved', 'Approved'),
  declined('declined', 'Declined');

  final String wire, label;
  const CreditStatus(this.wire, this.label);
  static CreditStatus fromWire(String? w) => values.firstWhere((s) => s.wire == w, orElse: () => draft);
}

class Signature {
  final String userId, userName;
  final CreditRole role;
  final DateTime at;
  const Signature(this.userId, this.userName, this.role, this.at);
  Map<String, dynamic> toJson() => {'userId': userId, 'userName': userName, 'role': role.wire, 'at': at.toIso8601String()};
  factory Signature.fromJson(Map<String, dynamic> j) =>
      Signature(j['userId'] as String, (j['userName'] ?? '') as String, CreditRole.fromWire(j['role'] as String?) ?? CreditRole.host, DateTime.parse(j['at'] as String));
}

class CreditApplication {
  final String id, playerId, createdBy, disposition, declineReason;
  final LineType lineType;
  final double amount;
  final CreditStatus status;
  final Map<String, dynamic> answers;
  final String? outcome;
  final List<String> referrals;
  final List<Signature> signatures;
  final DateTime createdAt;
  final DateTime? decidedAt;
  const CreditApplication({
    required this.id,
    required this.playerId,
    required this.createdBy,
    required this.lineType,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.disposition = 'Statement to residence — pay within 30 days of last marker',
    this.answers = const {},
    this.outcome,
    this.referrals = const [],
    this.signatures = const [],
    this.decidedAt,
    this.declineReason = '',
  });

  SignatureCheck get signatureCheck => Credit.checkSignatures(lineType, amount, signatures.map((s) => s.role).toList());

  CreditApplication copyWith({
    CreditStatus? status,
    Map<String, dynamic>? answers,
    String? outcome,
    List<String>? referrals,
    List<Signature>? signatures,
    DateTime? decidedAt,
    String? declineReason,
  }) =>
      CreditApplication(
        id: id, playerId: playerId, createdBy: createdBy, lineType: lineType, amount: amount, createdAt: createdAt,
        disposition: disposition,
        status: status ?? this.status,
        answers: answers ?? this.answers,
        outcome: outcome ?? this.outcome,
        referrals: referrals ?? this.referrals,
        signatures: signatures ?? this.signatures,
        decidedAt: decidedAt ?? this.decidedAt,
        declineReason: declineReason ?? this.declineReason,
      );

  Map<String, dynamic> toJson() => {
        'playerId': playerId, 'createdBy': createdBy, 'lineType': lineType.name, 'amount': amount, 'status': status.wire,
        'disposition': disposition, 'answers': answers, 'outcome': outcome, 'referrals': referrals,
        'signatures': signatures.map((s) => s.toJson()).toList(), 'createdAt': createdAt.toIso8601String(),
        'decidedAt': decidedAt?.toIso8601String(), 'declineReason': declineReason,
      };

  factory CreditApplication.fromJson(Map<String, dynamic> j) => CreditApplication(
        id: j['id'] as String,
        playerId: (j['playerId'] ?? '') as String,
        createdBy: (j['createdBy'] ?? '') as String,
        lineType: j['lineType'] == 'temporary' ? LineType.temporary : LineType.permanent,
        amount: _d(j['amount']),
        status: CreditStatus.fromWire(j['status'] as String?),
        disposition: (j['disposition'] ?? '') as String,
        answers: Map<String, dynamic>.from((j['answers'] ?? {}) as Map),
        outcome: j['outcome'] as String?,
        referrals: ((j['referrals'] ?? []) as List).cast<String>(),
        signatures: ((j['signatures'] ?? []) as List).map((e) => Signature.fromJson(Map<String, dynamic>.from(e as Map))).toList(),
        createdAt: _dtn(j['createdAt']) ?? DateTime.now(),
        decidedAt: _dtn(j['decidedAt']),
        declineReason: (j['declineReason'] ?? '') as String,
      );
}

enum MarkerStatus {
  open('open', 'Open'),
  paid('paid', 'Paid'),
  settled('settled', 'Settled'),
  writtenOff('written_off', 'Written off');

  final String wire, label;
  const MarkerStatus(this.wire, this.label);
  static MarkerStatus fromWire(String? w) => values.firstWhere((s) => s.wire == w, orElse: () => open);
}

class MarkerPayment {
  final double amount;
  final String method; // cash, cheques, check, wire
  final String recordedBy;
  final DateTime at;
  const MarkerPayment(this.amount, this.method, this.recordedBy, this.at);
  Map<String, dynamic> toJson() => {'amount': amount, 'method': method, 'recordedBy': recordedBy, 'at': at.toIso8601String()};
  factory MarkerPayment.fromJson(Map<String, dynamic> j) =>
      MarkerPayment(_d(j['amount']), (j['method'] ?? '') as String, (j['recordedBy'] ?? '') as String, DateTime.parse(j['at'] as String));
}

/// Marker = counter check signed at the table (Ch9 p.169). Settlement/write-off per Ch6 p.104–105.
class Marker {
  final String id, playerId, number, table, issuedBy;
  final double amount;
  final DateTime issuedAt;
  final List<MarkerPayment> payments;
  final MarkerStatus status;
  final double writeOffAmount;
  final String writeOffReason;
  final List<Signature> writeOffSignatures;
  final String collectionNote;
  const Marker({
    required this.id,
    required this.playerId,
    required this.number,
    required this.table,
    required this.issuedBy,
    required this.amount,
    required this.issuedAt,
    this.payments = const [],
    this.status = MarkerStatus.open,
    this.writeOffAmount = 0,
    this.writeOffReason = '',
    this.writeOffSignatures = const [],
    this.collectionNote = '',
  });
  double get paid => payments.fold(0, (a, p) => a + p.amount);
  double get balance => status == MarkerStatus.open ? (amount - paid).clamp(0, double.infinity).toDouble() : 0;
  int get ageDays => DateTime.now().difference(issuedAt).inDays;

  Marker copyWith({List<MarkerPayment>? payments, MarkerStatus? status, double? writeOffAmount, String? writeOffReason,
          List<Signature>? writeOffSignatures, String? collectionNote}) =>
      Marker(
        id: id, playerId: playerId, number: number, table: table, issuedBy: issuedBy, amount: amount, issuedAt: issuedAt,
        payments: payments ?? this.payments,
        status: status ?? this.status,
        writeOffAmount: writeOffAmount ?? this.writeOffAmount,
        writeOffReason: writeOffReason ?? this.writeOffReason,
        writeOffSignatures: writeOffSignatures ?? this.writeOffSignatures,
        collectionNote: collectionNote ?? this.collectionNote,
      );

  Map<String, dynamic> toJson() => {
        'playerId': playerId, 'number': number, 'table': table, 'issuedBy': issuedBy, 'amount': amount,
        'issuedAt': issuedAt.toIso8601String(), 'payments': payments.map((p) => p.toJson()).toList(), 'status': status.wire,
        'writeOffAmount': writeOffAmount, 'writeOffReason': writeOffReason,
        'writeOffSignatures': writeOffSignatures.map((s) => s.toJson()).toList(), 'collectionNote': collectionNote,
      };
  factory Marker.fromJson(Map<String, dynamic> j) => Marker(
        id: j['id'] as String,
        playerId: (j['playerId'] ?? '') as String,
        number: (j['number'] ?? '') as String,
        table: (j['table'] ?? '') as String,
        issuedBy: (j['issuedBy'] ?? '') as String,
        amount: _d(j['amount']),
        issuedAt: _dtn(j['issuedAt']) ?? DateTime.now(),
        payments: ((j['payments'] ?? []) as List).map((e) => MarkerPayment.fromJson(Map<String, dynamic>.from(e as Map))).toList(),
        status: MarkerStatus.fromWire(j['status'] as String?),
        writeOffAmount: _d(j['writeOffAmount']),
        writeOffReason: (j['writeOffReason'] ?? '') as String,
        writeOffSignatures:
            ((j['writeOffSignatures'] ?? []) as List).map((e) => Signature.fromJson(Map<String, dynamic>.from(e as Map))).toList(),
        collectionNote: (j['collectionNote'] ?? '') as String,
      );
}

final creditRepoProvider = Provider((ref) =>
    Repository<CreditApplication>(ref.watch(recordStoreProvider), 'credit_applications', CreditApplication.fromJson, (a) => a.toJson()));
final creditAppsProvider = StreamProvider<List<CreditApplication>>(
    (ref) => ref.watch(creditRepoProvider).watch().map((l) => l..sort((a, b) => b.createdAt.compareTo(a.createdAt))));

final markersRepoProvider =
    Provider((ref) => Repository<Marker>(ref.watch(recordStoreProvider), 'markers', Marker.fromJson, (m) => m.toJson()));
final markersProvider =
    StreamProvider<List<Marker>>((ref) => ref.watch(markersRepoProvider).watch().map((l) => l..sort((a, b) => b.issuedAt.compareTo(a.issuedAt))));

/// Approved line available to a player: approved lines (latest permanent + temporary) minus open marker balances.
({double line, double outstanding, double available}) availableCredit(List<CreditApplication> apps, List<Marker> markers, String playerId) {
  final approved = apps.where((a) => a.playerId == playerId && a.status == CreditStatus.approved).toList();
  double latest(LineType t) {
    final l = approved.where((a) => a.lineType == t).toList()..sort((a, b) => (b.decidedAt ?? b.createdAt).compareTo(a.decidedAt ?? a.createdAt));
    return l.isEmpty ? 0 : l.first.amount;
  }
  final perm = latest(LineType.permanent);
  final temp = latest(LineType.temporary);
  final line = temp > perm ? temp : perm;
  final out = markers.where((m) => m.playerId == playerId).fold<double>(0, (a, m) => a + m.balance);
  return (line: line, outstanding: out, available: (line - out).clamp(0, double.infinity).toDouble());
}
