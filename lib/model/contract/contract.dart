import 'package:json_annotation/json_annotation.dart';

part 'contract.g.dart';

@JsonSerializable()
class Contract {
  final int contractID;
  final int contractNumber;
  final int treeID;
  final int treePrice;
  final String customerUsername;
  final String farmerUsername;
  final int numOfYear;
  final DateTime date;
  final int shipFee;
  final int totalPrice;
  final int contractPrice;
  final int totalCrop;
  final String cancelParty;
  final String cancelReason;
  final int refund;
  final double totalYield;
  final int status;

  Contract({
    this.contractID,
    this.contractNumber,
    this.treeID,
    this.treePrice,
    this.customerUsername,
    this.farmerUsername,
    this.numOfYear,
    this.date,
    this.shipFee,
    this.totalPrice,
    this.contractPrice,
    this.totalCrop,
    this.cancelParty,
    this.cancelReason,
    this.refund,
    this.totalYield,
    this.status,
  });

  factory Contract.fromJson(Map<String, dynamic> json) =>
      _$ContractFromJson(json);

  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
