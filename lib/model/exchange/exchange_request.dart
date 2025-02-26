import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange_request.g.dart';

@JsonSerializable()
class ExchangeRequest {
  final int id;
  final String username;
  final int weight;
  final DateTime date;
  final int plantTypeID;
  final int contractID;
  final int status;
  final String plantTypeName;
  final String fullname;
  final String avatar;

  ExchangeRequest({
    this.id,
    this.username,
    this.weight,
    this.date,
    this.plantTypeID,
    this.contractID,
    this.status,
    this.plantTypeName,
    this.fullname,
    this.avatar
  });

  factory ExchangeRequest.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRequestToJson(this);
}
