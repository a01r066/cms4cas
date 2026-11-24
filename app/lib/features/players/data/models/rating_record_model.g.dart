// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatingRecordModel _$RatingRecordModelFromJson(Map<String, dynamic> json) =>
    _RatingRecordModel(
      id: json['id'] as String,
      playerId: json['playerId'] as String? ?? '',
      gameId: json['gameId'] as String? ?? '',
      gameName: json['gameName'] as String? ?? '',
      table: json['table'] as String? ?? '',
      ratedBy: json['ratedBy'] as String? ?? '',
      averageBet: (json['averageBet'] as num?)?.toDouble() ?? 0,
      minutes: (json['minutes'] as num?)?.toDouble() ?? 0,
      decisionsPerHour: (json['decisionsPerHour'] as num?)?.toDouble() ?? 0,
      effectiveAdvantage: (json['effectiveAdvantage'] as num?)?.toDouble() ?? 0,
      theo: (json['theo'] as num?)?.toDouble() ?? 0,
      actualCasinoWin: (json['actualCasinoWin'] as num?)?.toDouble() ?? 0,
      sd: (json['sd'] as num?)?.toDouble() ?? 0,
      players: (json['players'] as num?)?.toInt() ?? 1,
      type: json['type'] as String? ?? 'average',
      at: DateTime.parse(json['at'] as String),
    );

Map<String, dynamic> _$RatingRecordModelToJson(_RatingRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'gameId': instance.gameId,
      'gameName': instance.gameName,
      'table': instance.table,
      'ratedBy': instance.ratedBy,
      'averageBet': instance.averageBet,
      'minutes': instance.minutes,
      'decisionsPerHour': instance.decisionsPerHour,
      'effectiveAdvantage': instance.effectiveAdvantage,
      'theo': instance.theo,
      'actualCasinoWin': instance.actualCasinoWin,
      'sd': instance.sd,
      'players': instance.players,
      'type': instance.type,
      'at': instance.at.toIso8601String(),
    };
