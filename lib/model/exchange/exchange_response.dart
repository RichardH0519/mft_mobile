import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange_response.g.dart';

@JsonSerializable()
class ExchangeResponse {
  final int id;
  final String requestName;
  final int requestWeight;
  final String requestPlantName;
  final int responseWeight;
  final String responsePlantName;
  final DateTime date;
  final String responseName;
  final int status;
  final int exchangeRequestID;
  final String responseUsername;

  ExchangeResponse({
    this.id,
    this.requestName,
    this.requestWeight,
    this.requestPlantName,
    this.responseWeight,
    this.responsePlantName,
    this.date,
    this.responseName,
    this.status,
    this.exchangeRequestID,
    this.responseUsername,
  });

  factory ExchangeResponse.fromJson(Map<String, dynamic> json) =>
      _$ExchangeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeResponseToJson(this);
}
