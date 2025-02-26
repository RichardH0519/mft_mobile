import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_overview.g.dart';

@JsonSerializable()
class ContractOverview {
  final int id;
  final String treeCode;
  final String plantTypeName;
  final String gardenName;
  final String fullname;
  final int status;
  final int contractID;
  final int plantTypeID;
  final int totalPrice;
  final double totalYield;
  final String cancelParty;
  final int contractNumber;
  final String username;

  ContractOverview({
    @required this.id,
    @required this.treeCode,
    @required this.plantTypeName,
    @required this.gardenName,
    @required this.fullname,
    @required this.status,
    @required this.contractID,
    @required this.plantTypeID,
    @required this.totalPrice,
    @required this.totalYield,
    this.cancelParty,
    @required this.contractNumber,
    @required this.username,
  });

  factory ContractOverview.fromJson(Map<String, dynamic> json) =>
      _$ContractOverviewFromJson(json);

  Map<String, dynamic> toJson() => _$ContractOverviewToJson(this);
}
