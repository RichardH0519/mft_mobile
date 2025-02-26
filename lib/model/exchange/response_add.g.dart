// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseAdd _$ResponseAddFromJson(Map<String, dynamic> json) {
  return ResponseAdd(
    exchangeRequestID: json['exchangeRequestID'] as int,
    weight: json['weight'] as int,
    contractID: json['contractID'] as int,
    username: json['username'] as String,
    requestWeight: json['requestWeight'] as int,
  );
}

Map<String, dynamic> _$ResponseAddToJson(ResponseAdd instance) =>
    <String, dynamic>{
      'exchangeRequestID': instance.exchangeRequestID,
      'weight': instance.weight,
      'contractID': instance.contractID,
      'username': instance.username,
      'requestWeight': instance.requestWeight,
    };
