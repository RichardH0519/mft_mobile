import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_cancel_info.g.dart';

@JsonSerializable()
class ContractCancelInfo {
  final String cancelPartyName;
  final String cancelReason;
  final DateTime cancelDate;
  final int refund;

  ContractCancelInfo({
    this.cancelPartyName,
    this.cancelReason,
    this.cancelDate,
    this.refund,
  });

  factory ContractCancelInfo.fromJson(Map<String, dynamic> json) =>
      _$ContractCancelInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ContractCancelInfoToJson(this);
}
