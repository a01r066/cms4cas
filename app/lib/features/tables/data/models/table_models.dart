import 'package:casino_engine/casino_engine.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/hit_record.dart';
import '../../domain/entities/table_def.dart';
import '../../domain/entities/table_shift.dart';

part 'table_models.freezed.dart';
part 'table_models.g.dart';

/// casinos/{casinoId}/tables/{id}
@freezed
abstract class TableDefModel with _$TableDefModel {
  const TableDefModel._();

  const factory TableDefModel({
    required String id,
    @Default('') String name,
    @Default('blackjack') String gameId,
    @Default('') String pit,
    @Default(0) double minBet,
    @Default(0) double maxBet,
    @Default(0) double baseHold,
    @Default('marker') String system,
  }) = _TableDefModel;

  factory TableDefModel.fromJson(Map<String, dynamic> json) => _$TableDefModelFromJson(json);

  factory TableDefModel.fromEntity(TableDef t) => TableDefModel(
      id: t.id, name: t.name, gameId: t.gameId, pit: t.pit, minBet: t.minBet, maxBet: t.maxBet, baseHold: t.baseHold, system: t.system.wire);

  TableDef toEntity() => TableDef(
      id: id, name: name, gameId: gameId, pit: pit, minBet: minBet, maxBet: maxBet, baseHold: baseHold, system: MarkerSystem.fromWire(system));
}

/// casinos/{casinoId}/table_shifts/{id}. Inputs plus the computed drop/win/hold,
/// stored for reporting and audit.
@freezed
abstract class TableShiftModel with _$TableShiftModel {
  const TableShiftModel._();

  const factory TableShiftModel({
    required String id,
    @Default('') String tableId,
    @Default('') String shift,
    @Default('') String recordedBy,
    required DateTime gamingDay,
    DateTime? recordedAt,
    @Default(0) double openingInventory,
    @Default(0) double fills,
    @Default(0) double credits,
    @Default(0) double closingInventory,
    @Default(0) double currencyInBox,
    @Default(0) double chequesInBox,
    @Default(0) double markersIssued,
    @Default(0) double markersRedeemedInPitCash,
    @Default(0) double markersRedeemedInPitCheques,
    @Default('marker') String system,
    @Default(0) double drop,
    @Default(0) double win,
    @Default(0) double hold,
    @Default(0) double statisticalDrop,
  }) = _TableShiftModel;

  factory TableShiftModel.fromJson(Map<String, dynamic> json) => _$TableShiftModelFromJson(json);

  factory TableShiftModel.fromEntity(TableShift s) {
    final i = s.input;
    final r = s.result;
    return TableShiftModel(
      id: s.id,
      tableId: s.tableId,
      shift: s.shift,
      recordedBy: s.recordedBy,
      gamingDay: s.gamingDay,
      recordedAt: s.recordedAt,
      openingInventory: i.openingInventory,
      fills: i.fills,
      credits: i.credits,
      closingInventory: i.closingInventory,
      currencyInBox: i.currencyInBox,
      chequesInBox: i.chequesInBox,
      markersIssued: i.markersIssued,
      markersRedeemedInPitCash: i.markersRedeemedInPitCash,
      markersRedeemedInPitCheques: i.markersRedeemedInPitCheques,
      system: i.system.wire,
      drop: r.drop,
      win: r.win,
      hold: r.hold,
      statisticalDrop: r.statisticalDrop,
    );
  }

  TableShift toEntity() => TableShift(
        id: id,
        tableId: tableId,
        shift: shift,
        recordedBy: recordedBy,
        gamingDay: gamingDay,
        recordedAt: recordedAt ?? gamingDay,
        input: TableShiftInput(
          openingInventory: openingInventory,
          fills: fills,
          credits: credits,
          closingInventory: closingInventory,
          currencyInBox: currencyInBox,
          chequesInBox: chequesInBox,
          markersIssued: markersIssued,
          markersRedeemedInPitCash: markersRedeemedInPitCash,
          markersRedeemedInPitCheques: markersRedeemedInPitCheques,
          system: MarkerSystem.fromWire(system),
        ),
      );
}

/// casinos/{casinoId}/hits/{id}
@freezed
abstract class HitRecordModel with _$HitRecordModel {
  const HitRecordModel._();

  const factory HitRecordModel({
    required String id,
    @Default('') String tableId,
    @Default('') String playerLabel,
    required DateTime gamingDay,
    @Default(0) double playerDrop,
    @Default(0) double casinoResult,
    @Default('') String note,
    @Default('') String recordedBy,
  }) = _HitRecordModel;

  factory HitRecordModel.fromJson(Map<String, dynamic> json) => _$HitRecordModelFromJson(json);

  factory HitRecordModel.fromEntity(HitRecord h) => HitRecordModel(
      id: h.id, tableId: h.tableId, playerLabel: h.playerLabel, gamingDay: h.gamingDay, playerDrop: h.playerDrop,
      casinoResult: h.casinoResult, note: h.note, recordedBy: h.recordedBy);

  HitRecord toEntity() => HitRecord(
      id: id, tableId: tableId, playerLabel: playerLabel, gamingDay: gamingDay, playerDrop: playerDrop,
      casinoResult: casinoResult, note: note, recordedBy: recordedBy);
}
