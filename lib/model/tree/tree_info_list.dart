import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree/tree_info.dart';

class TreeInfoList {
  final List<TreeInfo> result;

  TreeInfoList({@required this.result});

  factory TreeInfoList.fromJson(List<dynamic> json) {
    List<TreeInfo> tree = [];
    tree = json.map((i) => TreeInfo.fromJson(i)).toList();

    return TreeInfoList(result: tree);
  }
}
