import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract/contract_cancel_info.dart';

class ContractCancelInfoList {
  final List<ContractCancelInfo> result;

  ContractCancelInfoList({@required this.result});

  factory ContractCancelInfoList.fromJson(List<dynamic> json) {
    List<ContractCancelInfo> contract = [];
    contract = json.map((i) => ContractCancelInfo.fromJson(i)).toList();

    return ContractCancelInfoList(result: contract);
  }
}
