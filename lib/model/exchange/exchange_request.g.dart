// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRequest _$ExchangeRequestFromJson(Map<String, dynamic> json) {
  return ExchangeRequest(
    id: json['id'] as int,
    username: json['username'] as String,
    weight: json['weight'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    plantTypeID: json['plantTypeID'] as int,
    contractID: json['contractID'] as int,
    status: json['status'] as int,
    plantTypeName: json['plantTypeName'] as String,
    fullname: json['fullname'] as String,
    avatar: json['avatar'] as String,
  );
}

Map<String, dynamic> _$ExchangeRequestToJson(ExchangeRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'weight': instance.weight,
      'date': instance.date?.toIso8601String(),
      'plantTypeID': instance.plantTypeID,
      'contractID': instance.contractID,
      'status': instance.status,
      'plantTypeName': instance.plantTypeName,
      'fullname': instance.fullname,
      'avatar': instance.avatar,
    };
