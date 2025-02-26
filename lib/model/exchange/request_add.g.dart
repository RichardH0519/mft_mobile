// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestAdd _$RequestAddFromJson(Map<String, dynamic> json) {
  return RequestAdd(
    plantTypeID: json['plantTypeID'] as int,
    weight: json['weight'] as int,
    contractID: json['contractID'] as int,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$RequestAddToJson(RequestAdd instance) =>
    <String, dynamic>{
      'plantTypeID': instance.plantTypeID,
      'weight': instance.weight,
      'contractID': instance.contractID,
      'username': instance.username,
    };
