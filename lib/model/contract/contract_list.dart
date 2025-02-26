import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract/contract.dart';

class ContractList {
  final List<Contract> result;

  ContractList({@required this.result});

  factory ContractList.fromJson(List<dynamic> json) {
    List<Contract> contract = [];
    contract = json.map((i) => Contract.fromJson(i)).toList();

    return ContractList(result: contract);
  }
}
