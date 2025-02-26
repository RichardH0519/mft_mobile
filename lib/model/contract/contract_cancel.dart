import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_cancel.g.dart';

@JsonSerializable()
class ContractCancel {
  final int contractID;
  final String cancelParty;
  final String cancelReason;
  final int refund;

  ContractCancel(
      {@required this.contractID,
      @required this.cancelParty,
      @required this.cancelReason,
      @required this.refund});

  factory ContractCancel.fromJson(Map<String, dynamic> json) =>
      _$ContractCancelFromJson(json);

  Map<String, dynamic> toJson() => _$ContractCancelToJson(this);
}
