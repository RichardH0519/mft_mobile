import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_detail.g.dart';

@JsonSerializable()
class ContractDetail {
  final int id;
  final int contractID;
  final DateTime startHarvest;
  final DateTime endHarvest;
  final DateTime deliveryDate;
  final double yield;
  final int status;

  ContractDetail({
    this.id,
    this.contractID,
    this.startHarvest,
    this.endHarvest,
    this.deliveryDate,
    this.yield,
    this.status,
  });

  factory ContractDetail.fromJson(Map<String, dynamic> json) =>
      _$ContractDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ContractDetailToJson(this);
}
