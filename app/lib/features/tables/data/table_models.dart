import 'package:casino_engine/casino_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/repository.dart';
import '../../../shared/providers.dart';

double _d(Object? v) => v is num ? v.toDouble() : 0;

class TableDef {
  final String id, name, gameId, pit;
  final double minBet, maxBet, baseHold; // baseHold = prior-year statistical hold (NV ±3% rule)
  final MarkerSystem system;
  const TableDef({required this.id, required this.name, required this.gameId, this.pit = '', this.minBet = 0, this.maxBet = 0, this.baseHold = 0, this.system = MarkerSystem.marker});
  Map<String, dynamic> toJson() => {'name': name, 'gameId': gameId, 'pit': pit, 'minBet': minBet, 'maxBet': maxBet, 'baseHold': baseHold, 'system': system.name};
  factory TableDef.fromJson(Map<String, dynamic> j) => TableDef(
        id: j['id'] as String, name: (j['name'] ?? '') as String, gameId: (j['gameId'] ?? 'blackjack') as String,
        pit: (j['pit'] ?? '') as String, minBet: _d(j['minBet']), maxBet: _d(j['maxBet']), baseHold: _d(j['baseHold']),
        system: j['system'] == 'nameCredit' ? MarkerSystem.nameCredit : MarkerSystem.marker,
      );
}

/// One shift (or gaming day) of a table: openers, fills/credits, drop-box contents, closer (Ch9).
class TableShift {
  final String id, tableId, shift, recordedBy;
  final DateTime gamingDay, recordedAt;
  final TableShiftInput input;
  const TableShift({required this.id, required this.tableId, required this.shift, required this.recordedBy, required this.gamingDay, required this.recordedAt, required this.input});
  TableShiftResult get result => TableGames.compute(input);
  Map<String, dynamic> toJson() => {
        'tableId': tableId, 'shift': shift, 'recordedBy': recordedBy, 'gamingDay': gamingDay.toIso8601String(), 'recordedAt': recordedAt.toIso8601String(),
        'openingInventory': input.openingInventory, 'fills': input.fills, 'credits': input.credits, 'closingInventory': input.closingInventory,
        'currencyInBox': input.currencyInBox, 'chequesInBox': input.chequesInBox, 'markersIssued': input.markersIssued,
        'markersRedeemedInPitCash': input.markersRedeemedInPitCash, 'markersRedeemedInPitCheques': input.markersRedeemedInPitCheques,
        'system': input.system.name,
        // computed values stored for reporting / audit
        'drop': result.drop, 'win': result.win, 'hold': result.hold, 'statisticalDrop': result.statisticalDrop,
      };
  factory TableShift.fromJson(Map<String, dynamic> j) => TableShift(
        id: j['id'] as String, tableId: (j['tableId'] ?? '') as String, shift: (j['shift'] ?? '') as String,
        recordedBy: (j['recordedBy'] ?? '') as String, gamingDay: DateTime.parse(j['gamingDay'] as String),
        recordedAt: DateTime.parse((j['recordedAt'] ?? j['gamingDay']) as String),
        input: TableShiftInput(
          openingInventory: _d(j['openingInventory']), fills: _d(j['fills']), credits: _d(j['credits']), closingInventory: _d(j['closingInventory']),
          currencyInBox: _d(j['currencyInBox']), chequesInBox: _d(j['chequesInBox']), markersIssued: _d(j['markersIssued']),
          markersRedeemedInPitCash: _d(j['markersRedeemedInPitCash']), markersRedeemedInPitCheques: _d(j['markersRedeemedInPitCheques']),
          system: j['system'] == 'nameCredit' ? MarkerSystem.nameCredit : MarkerSystem.marker,
        ),
      );
}

/// A documented large win/loss ("hit") to exclude from hold analysis (Ch13 p.249).
class HitRecord {
  final String id, tableId, playerLabel, note, recordedBy;
  final DateTime gamingDay;
  final double playerDrop, casinoResult;
  const HitRecord({required this.id, required this.tableId, required this.playerLabel, required this.gamingDay, required this.playerDrop, required this.casinoResult, this.note = '', this.recordedBy = ''});
  Map<String, dynamic> toJson() => {'tableId': tableId, 'playerLabel': playerLabel, 'gamingDay': gamingDay.toIso8601String(), 'playerDrop': playerDrop, 'casinoResult': casinoResult, 'note': note, 'recordedBy': recordedBy};
  factory HitRecord.fromJson(Map<String, dynamic> j) => HitRecord(
        id: j['id'] as String, tableId: (j['tableId'] ?? '') as String, playerLabel: (j['playerLabel'] ?? '') as String,
        gamingDay: DateTime.parse(j['gamingDay'] as String), playerDrop: _d(j['playerDrop']), casinoResult: _d(j['casinoResult']),
        note: (j['note'] ?? '') as String, recordedBy: (j['recordedBy'] ?? '') as String,
      );
}

final tablesRepoProvider = Provider((ref) => Repository<TableDef>(ref.watch(recordStoreProvider), 'tables', TableDef.fromJson, (t) => t.toJson()));
final tablesProvider = StreamProvider<List<TableDef>>((ref) => ref.watch(tablesRepoProvider).watch().map((l) => l..sort((a, b) => a.name.compareTo(b.name))));
final shiftsRepoProvider = Provider((ref) => Repository<TableShift>(ref.watch(recordStoreProvider), 'table_shifts', TableShift.fromJson, (t) => t.toJson()));
final shiftsProvider = StreamProvider<List<TableShift>>((ref) => ref.watch(shiftsRepoProvider).watch().map((l) => l..sort((a, b) => b.gamingDay.compareTo(a.gamingDay))));
final hitsRepoProvider = Provider((ref) => Repository<HitRecord>(ref.watch(recordStoreProvider), 'hits', HitRecord.fromJson, (t) => t.toJson()));
final hitsProvider = StreamProvider<List<HitRecord>>((ref) => ref.watch(hitsRepoProvider).watch());

class HoldSummary {
  final double drop, win, statDrop, hitDrop, hitResult;
  const HoldSummary(this.drop, this.win, this.statDrop, this.hitDrop, this.hitResult);
  double get hold => drop == 0 ? 0 : win / drop;
  double get statHold => statDrop == 0 ? 0 : win / statDrop;
  double get adjustedHold {
    final r = TableGames.removeHit(totalWin: win, totalDrop: statDrop, playerDrop: hitDrop, casinoResult: hitResult);
    return r.drop <= 0 ? 0 : r.win / r.drop;
  }

  static HoldSummary of(List<TableShift> s, List<HitRecord> h) => HoldSummary(
        s.fold(0, (a, x) => a + x.result.drop), s.fold(0, (a, x) => a + x.result.win), s.fold(0, (a, x) => a + x.result.statisticalDrop),
        h.fold(0, (a, x) => a + x.playerDrop), h.fold(0, (a, x) => a + x.casinoResult));
}
