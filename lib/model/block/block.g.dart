// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) {
  return Block(
    username: json['username'] as String,
    blocked: json['blocked'] as String,
  );
}

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'username': instance.username,
      'blocked': instance.blocked,
    };
