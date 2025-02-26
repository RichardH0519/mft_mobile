import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree/tree_contract_info.dart';

class TreeContractInfoList {
  final List<TreeContractInfo> result;

  TreeContractInfoList({@required this.result});

  factory TreeContractInfoList.fromJson(List<dynamic> json) {
    List<TreeContractInfo> trees = [];
    trees = json.map((i) => TreeContractInfo.fromJson(i)).toList();

    return TreeContractInfoList(result: trees);
  }
}
