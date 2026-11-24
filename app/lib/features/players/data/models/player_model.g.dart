// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) => _PlayerModel(
  id: json['id'] as String,
  name: json['name'] as String? ?? '',
  playerNo: json['playerNo'] as String? ?? '',
  idDocument: json['idDocument'] as String? ?? '',
  address: json['address'] as String? ?? '',
  notes: json['notes'] as String? ?? '',
  createdBy: json['createdBy'] as String? ?? '',
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PlayerModelToJson(_PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'playerNo': instance.playerNo,
      'idDocument': instance.idDocument,
      'address': instance.address,
      'notes': instance.notes,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
    };
