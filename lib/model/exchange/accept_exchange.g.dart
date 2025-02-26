// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptExchange _$AcceptExchangeFromJson(Map<String, dynamic> json) {
  return AcceptExchange(
    requestID: json['requestID'] as int,
    responseID: json['responseID'] as int,
  );
}

Map<String, dynamic> _$AcceptExchangeToJson(AcceptExchange instance) =>
    <String, dynamic>{
      'requestID': instance.requestID,
      'responseID': instance.responseID,
    };
