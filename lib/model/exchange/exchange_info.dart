import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mft_customer_side/model/exchange/exchange_management.dart';

part 'exchange_info.g.dart';

@JsonSerializable()
class ExchangeInfo {
  final ExchangeManagement mag;
  final String requestFullname;
  final String requestUsername;
  final String responseFullname;
  final String responseUsername;
  final int requestWeight;
  final int weight;
  final String responsePlant;
  final String requestPlant;
  final String requestPhone;
  final String responsePhone;

  ExchangeInfo({
    @required this.mag,
    @required this.requestFullname,
    @required this.requestUsername,
    @required this.responseFullname,
    @required this.responseUsername,
    @required this.requestWeight,
    @required this.weight,
    @required this.responsePlant,
    @required this.requestPlant,
    @required this.requestPhone,
    @required this.responsePhone,
  });

  factory ExchangeInfo.fromJson(Map<String, dynamic> json) =>
      _$ExchangeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeInfoToJson(this);
}
