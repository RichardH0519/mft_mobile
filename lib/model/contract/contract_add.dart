import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_add.g.dart';

@JsonSerializable()
class ContractAdd {
  final int treeID;
  final String customerUsername;
  final String farmerUsername;
  final int numOfYear;
  final int totalPrice;
  final double totalYield;
  final int totalCrop;
  final int shipFee;

  ContractAdd({
    @required this.treeID,
    @required this.customerUsername,
    @required this.farmerUsername,
    @required this.numOfYear,
    @required this.totalPrice,
    @required this.totalYield,
    @required this.totalCrop,
    @required this.shipFee,
  });

  factory ContractAdd.fromJson(Map<String, dynamic> json) =>
      _$ContractAddFromJson(json);

  Map<String, dynamic> toJson() => _$ContractAddToJson(this);
}
