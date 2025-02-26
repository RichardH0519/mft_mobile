// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockedInfo _$BlockedInfoFromJson(Map<String, dynamic> json) {
  return BlockedInfo(
    b: json['b'] == null
        ? null
        : Blocked.fromJson(json['b'] as Map<String, dynamic>),
    fullname: json['fullname'] as String,
  );
}

Map<String, dynamic> _$BlockedInfoToJson(BlockedInfo instance) =>
    <String, dynamic>{
      'b': instance.b,
      'fullname': instance.fullname,
    };
