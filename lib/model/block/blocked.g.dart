// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blocked _$BlockedFromJson(Map<String, dynamic> json) {
  return Blocked(
    id: json['id'] as int,
    username: json['username'] as String,
    blocked: json['blocked'] as String,
  );
}

Map<String, dynamic> _$BlockedToJson(Blocked instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'blocked': instance.blocked,
    };
