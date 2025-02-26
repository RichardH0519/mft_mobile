import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_rate.g.dart';

@JsonSerializable()
class ContractRate {
  final double totalYield;
  final int totalPrice;

  ContractRate({
    @required this.totalYield,
    @required this.totalPrice,
  });

  factory ContractRate.fromJson(Map<String, dynamic> json) =>
      _$ContractRateFromJson(json);

  Map<String, dynamic> toJson() => _$ContractRateToJson(this);
}
