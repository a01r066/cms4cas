import 'dart:math' as math;
import 'package:casino_engine/casino_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/repository.dart';
import '../../../shared/providers.dart';

DateTime _dt(Object? v) => v is String ? DateTime.parse(v) : DateTime.fromMillisecondsSinceEpoch(0);
double _d(Object? v) => v is num ? v.toDouble() : 0;

class Player {
  final String id, name, playerNo, idDocument, address, notes, createdBy;
  final DateTime createdAt;
  const Player({
    required this.id,
    required this.name,
    this.playerNo = '',
    this.idDocument = '',
    this.address = '',
    this.notes = '',
    required this.createdBy,
    required this.createdAt,
  });
  bool get hasIdOnFile => idDocument.trim().isNotEmpty && address.trim().isNotEmpty;
  Map<String, dynamic> toJson() => {
        'name': name, 'playerNo': playerNo, 'idDocument': idDocument, 'address': address, 'notes': notes,
        'createdBy': createdBy, 'createdAt': createdAt.toIso8601String(),
      };
  factory Player.fromJson(Map<String, dynamic> j) => Player(
        id: j['id'] as String,
        name: (j['name'] ?? '') as String,
        playerNo: (j['playerNo'] ?? '') as String,
        idDocument: (j['idDocument'] ?? '') as String,
        address: (j['address'] ?? '') as String,
        notes: (j['notes'] ?? '') as String,
        createdBy: (j['createdBy'] ?? '') as String,
        createdAt: _dt(j['createdAt']),
      );
}

/// One rated session (Ch12 rating card, Fig 12.1).
class RatingRecord {
  final String id, playerId, gameId, gameName, table, ratedBy;
  final double averageBet, minutes, decisionsPerHour, effectiveAdvantage, theo, actualCasinoWin, sd;
  final int players;
  final PlayerType type;
  final DateTime at;
  const RatingRecord({
    required this.id,
    required this.playerId,
    required this.gameId,
    required this.gameName,
    required this.table,
    required this.ratedBy,
    required this.averageBet,
    required this.minutes,
    required this.decisionsPerHour,
    required this.effectiveAdvantage,
    required this.theo,
    required this.actualCasinoWin,
    required this.sd,
    required this.players,
    required this.type,
    required this.at,
  });
  double get hours => minutes / 60;
  Map<String, dynamic> toJson() => {
        'playerId': playerId, 'gameId': gameId, 'gameName': gameName, 'table': table, 'ratedBy': ratedBy,
        'averageBet': averageBet, 'minutes': minutes, 'decisionsPerHour': decisionsPerHour,
        'effectiveAdvantage': effectiveAdvantage, 'theo': theo, 'actualCasinoWin': actualCasinoWin, 'sd': sd,
        'players': players, 'type': type.wire, 'at': at.toIso8601String(),
      };
  factory RatingRecord.fromJson(Map<String, dynamic> j) => RatingRecord(
        id: j['id'] as String,
        playerId: (j['playerId'] ?? '') as String,
        gameId: (j['gameId'] ?? '') as String,
        gameName: (j['gameName'] ?? '') as String,
        table: (j['table'] ?? '') as String,
        ratedBy: (j['ratedBy'] ?? '') as String,
        averageBet: _d(j['averageBet']),
        minutes: _d(j['minutes']),
        decisionsPerHour: _d(j['decisionsPerHour']),
        effectiveAdvantage: _d(j['effectiveAdvantage']),
        theo: _d(j['theo']),
        actualCasinoWin: _d(j['actualCasinoWin']),
        sd: _d(j['sd']),
        players: (j['players'] as num?)?.toInt() ?? 1,
        type: PlayerType.fromWire((j['type'] ?? 'average') as String),
        at: _dt(j['at']),
      );
}

class TripSummary {
  final int sessions;
  final double hours, theo, actualCasinoWin, weightedAvgBet, sd;
  const TripSummary(this.sessions, this.hours, this.theo, this.actualCasinoWin, this.weightedAvgBet, this.sd);

  factory TripSummary.of(List<RatingRecord> r) {
    if (r.isEmpty) return const TripSummary(0, 0, 0, 0, 0, 0);
    final hours = r.fold<double>(0, (a, x) => a + x.hours);
    final variance = r.fold<double>(0, (a, x) => a + x.sd * x.sd);
    return TripSummary(
      r.length,
      hours,
      r.fold(0, (a, x) => a + x.theo),
      r.fold(0, (a, x) => a + x.actualCasinoWin),
      Stats.weightedAverageBet(r.map((x) => (bet: x.averageBet, hours: x.hours)).toList()),
      variance <= 0 ? 0 : math.sqrt(variance),
    );
  }
}

final playersRepoProvider =
    Provider((ref) => Repository<Player>(ref.watch(recordStoreProvider), 'players', Player.fromJson, (p) => p.toJson()));
final playersProvider = StreamProvider<List<Player>>((ref) =>
    ref.watch(playersRepoProvider).watch().map((l) => l..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()))));
final playerByIdProvider = Provider.family<Player?, String>((ref, id) {
  for (final p in ref.watch(playersProvider).value ?? const <Player>[]) {
    if (p.id == id) return p;
  }
  return null;
});

final ratingsRepoProvider =
    Provider((ref) => Repository<RatingRecord>(ref.watch(recordStoreProvider), 'ratings', RatingRecord.fromJson, (r) => r.toJson()));
final ratingsProvider = StreamProvider<List<RatingRecord>>((ref) =>
    ref.watch(ratingsRepoProvider).watch().map((l) => l..sort((a, b) => b.at.compareTo(a.at))));
final ratingsForPlayerProvider = Provider.family<List<RatingRecord>, String>(
    (ref, id) => (ref.watch(ratingsProvider).value ?? const <RatingRecord>[]).where((r) => r.playerId == id).toList());
