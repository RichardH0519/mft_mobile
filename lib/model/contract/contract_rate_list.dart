import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract/contract_rate.dart';

class ContractRateList {
  final List<ContractRate> result;

  ContractRateList({@required this.result});

  factory ContractRateList.fromJson(List<dynamic> json) {
    List<ContractRate> contractRate = [];
    contractRate = json.map((i) => ContractRate.fromJson(i)).toList();

    return ContractRateList(result: contractRate);
  }
}
