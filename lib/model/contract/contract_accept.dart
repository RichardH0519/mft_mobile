import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_accept.g.dart';

@JsonSerializable()
class ContractAccept {
  final int treeID;
  final int contractID;

  ContractAccept({
    @required this.treeID,
    @required this.contractID
  });

  factory ContractAccept.fromJson(Map<String, dynamic> json) =>
      _$ContractAcceptFromJson(json);

  Map<String, dynamic> toJson() => _$ContractAcceptToJson(this);
}
