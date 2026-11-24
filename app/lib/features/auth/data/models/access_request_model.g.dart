// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccessRequestModel _$AccessRequestModelFromJson(Map<String, dynamic> json) =>
    _AccessRequestModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      requestedAt: DateTime.parse(json['requestedAt'] as String),
    );

Map<String, dynamic> _$AccessRequestModelToJson(_AccessRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'requestedAt': instance.requestedAt.toIso8601String(),
    };
