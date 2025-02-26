// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelExchange _$CancelExchangeFromJson(Map<String, dynamic> json) {
  return CancelExchange(
    requestID: json['requestID'] as int,
    responseID: json['responseID'] as int,
    managementID: json['managementID'] as int,
  );
}

Map<String, dynamic> _$CancelExchangeToJson(CancelExchange instance) =>
    <String, dynamic>{
      'requestID': instance.requestID,
      'responseID': instance.responseID,
      'managementID': instance.managementID,
    };
