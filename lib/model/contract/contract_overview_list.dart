import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract/contract_overview.dart';

class ContractOverviewList {
  final List<ContractOverview> result;

  ContractOverviewList({@required this.result});

  factory ContractOverviewList.fromJson(List<dynamic> json) {
    List<ContractOverview> contracts = [];
    contracts = json.map((i) => ContractOverview.fromJson(i)).toList();

    return ContractOverviewList(result: contracts);
  }
}
