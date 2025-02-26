// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeResponse _$ExchangeResponseFromJson(Map<String, dynamic> json) {
  return ExchangeResponse(
    id: json['id'] as int,
    requestName: json['requestName'] as String,
    requestWeight: json['requestWeight'] as int,
    requestPlantName: json['requestPlantName'] as String,
    responseWeight: json['responseWeight'] as int,
    responsePlantName: json['responsePlantName'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    responseName: json['responseName'] as String,
    status: json['status'] as int,
    exchangeRequestID: json['exchangeRequestID'] as int,
    responseUsername: json['responseUsername'] as String,
  );
}

Map<String, dynamic> _$ExchangeResponseToJson(ExchangeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestName': instance.requestName,
      'requestWeight': instance.requestWeight,
      'requestPlantName': instance.requestPlantName,
      'responseWeight': instance.responseWeight,
      'responsePlantName': instance.responsePlantName,
      'date': instance.date?.toIso8601String(),
      'responseName': instance.responseName,
      'status': instance.status,
      'exchangeRequestID': instance.exchangeRequestID,
      'responseUsername': instance.responseUsername,
    };
