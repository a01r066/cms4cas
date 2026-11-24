import 'package:casino_engine/casino_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/repository.dart';
import '../../../shared/providers.dart';

double _d(Object? v) => v is num ? v.toDouble() : 0;

class CashTxRecord {
  final String id, patronKey, patronLabel, area, recordedBy;
  final CashTxType type;
  final double amount;
  final DateTime at;
  final String? visitId;
  const CashTxRecord({required this.id, required this.patronKey, required this.patronLabel, required this.area, required this.recordedBy, required this.type, required this.amount, required this.at, this.visitId});
  CashTx get tx => CashTx(id: id, patronKey: patronKey, type: type, amount: amount, area: area, at: at, visitId: visitId);
  Map<String, dynamic> toJson() => {'patronKey': patronKey, 'patronLabel': patronLabel, 'area': area, 'recordedBy': recordedBy, 'type': type.wire, 'amount': amount, 'at': at.toIso8601String(), 'visitId': visitId};
  factory CashTxRecord.fromJson(Map<String, dynamic> j) => CashTxRecord(
        id: j['id'] as String, patronKey: (j['patronKey'] ?? '') as String, patronLabel: (j['patronLabel'] ?? '') as String,
        area: (j['area'] ?? '') as String, recordedBy: (j['recordedBy'] ?? '') as String, type: CashTxType.fromWire((j['type'] ?? '') as String),
        amount: _d(j['amount']), at: DateTime.parse(j['at'] as String), visitId: j['visitId'] as String?,
      );
}

enum CtrStatus { draft, prepared, reviewed, filed }

class CtrReport {
  final String id, patronKey, patronLabel, aggregateLabel, direction, preparedBy, preparedById, reviewedBy, reviewedById;
  final DateTime gamingDay;
  final double total;
  final List<String> txIds;
  final Map<String, bool> fields;
  final CtrStatus status;
  final DateTime? filedAt;
  const CtrReport({
    required this.id, required this.patronKey, required this.patronLabel, required this.aggregateLabel, required this.direction,
    required this.gamingDay, required this.total, required this.txIds, this.fields = const {}, this.status = CtrStatus.draft,
    this.preparedBy = '', this.preparedById = '', this.reviewedBy = '', this.reviewedById = '', this.filedAt,
  });
  bool get multiple => txIds.length > 1;
  bool get complete => Aml.ctrRequiredFields.take(8).every((f) => fields[f] == true);
  CtrReport copyWith({Map<String, bool>? fields, CtrStatus? status, String? preparedBy, String? preparedById, String? reviewedBy, String? reviewedById, DateTime? filedAt}) => CtrReport(
        id: id, patronKey: patronKey, patronLabel: patronLabel, aggregateLabel: aggregateLabel, direction: direction, gamingDay: gamingDay,
        total: total, txIds: txIds, fields: fields ?? this.fields, status: status ?? this.status, preparedBy: preparedBy ?? this.preparedBy,
        preparedById: preparedById ?? this.preparedById, reviewedBy: reviewedBy ?? this.reviewedBy, reviewedById: reviewedById ?? this.reviewedById,
        filedAt: filedAt ?? this.filedAt,
      );
  Map<String, dynamic> toJson() => {
        'patronKey': patronKey, 'patronLabel': patronLabel, 'aggregateLabel': aggregateLabel, 'direction': direction,
        'gamingDay': gamingDay.toIso8601String(), 'total': total, 'txIds': txIds, 'fields': fields, 'status': status.name,
        'preparedBy': preparedBy, 'preparedById': preparedById, 'reviewedBy': reviewedBy, 'reviewedById': reviewedById, 'filedAt': filedAt?.toIso8601String(),
      };
  factory CtrReport.fromJson(Map<String, dynamic> j) => CtrReport(
        id: j['id'] as String, patronKey: (j['patronKey'] ?? '') as String, patronLabel: (j['patronLabel'] ?? '') as String,
        aggregateLabel: (j['aggregateLabel'] ?? '') as String, direction: (j['direction'] ?? '') as String,
        gamingDay: DateTime.parse(j['gamingDay'] as String), total: _d(j['total']), txIds: ((j['txIds'] ?? []) as List).cast<String>(),
        fields: Map<String, dynamic>.from((j['fields'] ?? {}) as Map).map((k, v) => MapEntry(k, v == true)),
        status: CtrStatus.values.firstWhere((s) => s.name == j['status'], orElse: () => CtrStatus.draft),
        preparedBy: (j['preparedBy'] ?? '') as String, preparedById: (j['preparedById'] ?? '') as String,
        reviewedBy: (j['reviewedBy'] ?? '') as String, reviewedById: (j['reviewedById'] ?? '') as String,
        filedAt: j['filedAt'] == null ? null : DateTime.parse(j['filedAt'] as String),
      );
}

class BarredPatron {
  final String id, description, reason, playerId, addedBy;
  final DateTime since;
  final bool active;
  const BarredPatron({required this.id, required this.description, required this.reason, this.playerId = '', this.addedBy = '', required this.since, this.active = true});
  Map<String, dynamic> toJson() => {'description': description, 'reason': reason, 'playerId': playerId, 'addedBy': addedBy, 'since': since.toIso8601String(), 'active': active};
  factory BarredPatron.fromJson(Map<String, dynamic> j) => BarredPatron(
        id: j['id'] as String, description: (j['description'] ?? '') as String, reason: (j['reason'] ?? '') as String,
        playerId: (j['playerId'] ?? '') as String, addedBy: (j['addedBy'] ?? '') as String, since: DateTime.parse(j['since'] as String), active: (j['active'] ?? true) as bool,
      );
}

class SarCase {
  final String id, subject, summary, openedBy;
  final double amount;
  final DateTime detectedAt;
  final bool extended;
  final DateTime? filedAt;
  const SarCase({required this.id, required this.subject, required this.summary, required this.openedBy, required this.amount, required this.detectedAt, this.extended = false, this.filedAt});
  Map<String, dynamic> toJson() => {'subject': subject, 'summary': summary, 'openedBy': openedBy, 'amount': amount, 'detectedAt': detectedAt.toIso8601String(), 'extended': extended, 'filedAt': filedAt?.toIso8601String()};
  factory SarCase.fromJson(Map<String, dynamic> j) => SarCase(
        id: j['id'] as String, subject: (j['subject'] ?? '') as String, summary: (j['summary'] ?? '') as String, openedBy: (j['openedBy'] ?? '') as String,
        amount: _d(j['amount']), detectedAt: DateTime.parse(j['detectedAt'] as String), extended: (j['extended'] ?? false) as bool,
        filedAt: j['filedAt'] == null ? null : DateTime.parse(j['filedAt'] as String),
      );
}

final cashTxRepoProvider = Provider((ref) => Repository<CashTxRecord>(ref.watch(recordStoreProvider), 'cash_transactions', CashTxRecord.fromJson, (x) => x.toJson()));
final cashTxProvider = StreamProvider<List<CashTxRecord>>((ref) => ref.watch(cashTxRepoProvider).watch().map((l) => l..sort((a, b) => b.at.compareTo(a.at))));
final ctrRepoProvider = Provider((ref) => Repository<CtrReport>(ref.watch(recordStoreProvider), 'ctr_reports', CtrReport.fromJson, (x) => x.toJson()));
final ctrProvider = StreamProvider<List<CtrReport>>((ref) => ref.watch(ctrRepoProvider).watch());
final barredRepoProvider = Provider((ref) => Repository<BarredPatron>(ref.watch(recordStoreProvider), 'barred_patrons', BarredPatron.fromJson, (x) => x.toJson()));
final barredProvider = StreamProvider<List<BarredPatron>>((ref) => ref.watch(barredRepoProvider).watch());
final sarRepoProvider = Provider((ref) => Repository<SarCase>(ref.watch(recordStoreProvider), 'sar_cases', SarCase.fromJson, (x) => x.toJson()));
final sarProvider = StreamProvider<List<SarCase>>((ref) => ref.watch(sarRepoProvider).watch());
