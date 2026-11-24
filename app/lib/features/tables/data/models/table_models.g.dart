// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TableDefModel _$TableDefModelFromJson(Map<String, dynamic> json) =>
    _TableDefModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      gameId: json['gameId'] as String? ?? 'blackjack',
      pit: json['pit'] as String? ?? '',
      minBet: (json['minBet'] as num?)?.toDouble() ?? 0,
      maxBet: (json['maxBet'] as num?)?.toDouble() ?? 0,
      baseHold: (json['baseHold'] as num?)?.toDouble() ?? 0,
      system: json['system'] as String? ?? 'marker',
    );

Map<String, dynamic> _$TableDefModelToJson(_TableDefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gameId': instance.gameId,
      'pit': instance.pit,
      'minBet': instance.minBet,
      'maxBet': instance.maxBet,
      'baseHold': instance.baseHold,
      'system': instance.system,
    };

_TableShiftModel _$TableShiftModelFromJson(Map<String, dynamic> json) =>
    _TableShiftModel(
      id: json['id'] as String,
      tableId: json['tableId'] as String? ?? '',
      shift: json['shift'] as String? ?? '',
      recordedBy: json['recordedBy'] as String? ?? '',
      gamingDay: DateTime.parse(json['gamingDay'] as String),
      recordedAt: json['recordedAt'] == null
          ? null
          : DateTime.parse(json['recordedAt'] as String),
      openingInventory: (json['openingInventory'] as num?)?.toDouble() ?? 0,
      fills: (json['fills'] as num?)?.toDouble() ?? 0,
      credits: (json['credits'] as num?)?.toDouble() ?? 0,
      closingInventory: (json['closingInventory'] as num?)?.toDouble() ?? 0,
      currencyInBox: (json['currencyInBox'] as num?)?.toDouble() ?? 0,
      chequesInBox: (json['chequesInBox'] as num?)?.toDouble() ?? 0,
      markersIssued: (json['markersIssued'] as num?)?.toDouble() ?? 0,
      markersRedeemedInPitCash:
          (json['markersRedeemedInPitCash'] as num?)?.toDouble() ?? 0,
      markersRedeemedInPitCheques:
          (json['markersRedeemedInPitCheques'] as num?)?.toDouble() ?? 0,
      system: json['system'] as String? ?? 'marker',
      drop: (json['drop'] as num?)?.toDouble() ?? 0,
      win: (json['win'] as num?)?.toDouble() ?? 0,
      hold: (json['hold'] as num?)?.toDouble() ?? 0,
      statisticalDrop: (json['statisticalDrop'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$TableShiftModelToJson(_TableShiftModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableId': instance.tableId,
      'shift': instance.shift,
      'recordedBy': instance.recordedBy,
      'gamingDay': instance.gamingDay.toIso8601String(),
      'recordedAt': instance.recordedAt?.toIso8601String(),
      'openingInventory': instance.openingInventory,
      'fills': instance.fills,
      'credits': instance.credits,
      'closingInventory': instance.closingInventory,
      'currencyInBox': instance.currencyInBox,
      'chequesInBox': instance.chequesInBox,
      'markersIssued': instance.markersIssued,
      'markersRedeemedInPitCash': instance.markersRedeemedInPitCash,
      'markersRedeemedInPitCheques': instance.markersRedeemedInPitCheques,
      'system': instance.system,
      'drop': instance.drop,
      'win': instance.win,
      'hold': instance.hold,
      'statisticalDrop': instance.statisticalDrop,
    };

_HitRecordModel _$HitRecordModelFromJson(Map<String, dynamic> json) =>
    _HitRecordModel(
      id: json['id'] as String,
      tableId: json['tableId'] as String? ?? '',
      playerLabel: json['playerLabel'] as String? ?? '',
      gamingDay: DateTime.parse(json['gamingDay'] as String),
      playerDrop: (json['playerDrop'] as num?)?.toDouble() ?? 0,
      casinoResult: (json['casinoResult'] as num?)?.toDouble() ?? 0,
      note: json['note'] as String? ?? '',
      recordedBy: json['recordedBy'] as String? ?? '',
    );

Map<String, dynamic> _$HitRecordModelToJson(_HitRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableId': instance.tableId,
      'playerLabel': instance.playerLabel,
      'gamingDay': instance.gamingDay.toIso8601String(),
      'playerDrop': instance.playerDrop,
      'casinoResult': instance.casinoResult,
      'note': instance.note,
      'recordedBy': instance.recordedBy,
    };
