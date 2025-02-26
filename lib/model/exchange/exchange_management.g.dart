// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_management.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeManagement _$ExchangeManagementFromJson(Map<String, dynamic> json) {
  return ExchangeManagement(
    id: json['id'] as int,
    requestID: json['requestID'] as int,
    responseID: json['responseID'] as int,
    requestReceived: json['requestReceived'] as bool,
    responseReceived: json['responseReceived'] as bool,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$ExchangeManagementToJson(ExchangeManagement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestID': instance.requestID,
      'responseID': instance.responseID,
      'requestReceived': instance.requestReceived,
      'responseReceived': instance.responseReceived,
      'status': instance.status,
    };
