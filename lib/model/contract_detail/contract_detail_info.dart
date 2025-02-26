import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mft_customer_side/model/contract_detail/contract_detail.dart';

part 'contract_detail_info.g.dart';

@JsonSerializable()
class ContractDetailInfo {
  final ContractDetail cd;
  final double remainYield;
  final double exchangedYield;

  ContractDetailInfo({
    this.cd,
    this.remainYield,
    this.exchangedYield,
  });

  factory ContractDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$ContractDetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ContractDetailInfoToJson(this);
}
