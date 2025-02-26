import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract_detail/contract_detail.dart';
import 'package:mft_customer_side/model/contract_detail/contract_detail_info.dart';

class ContractDetailList {
  final List<ContractDetailInfo> result;

  ContractDetailList({@required this.result});

  factory ContractDetailList.fromJson(List<dynamic> json) {
    List<ContractDetailInfo> contractDetails = [];
    contractDetails = json.map((i) => ContractDetailInfo.fromJson(i)).toList();

    return ContractDetailList(result: contractDetails);
  }
}
