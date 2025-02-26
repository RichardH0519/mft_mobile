import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree_type/tree_type.dart';

class TreeTypeList {
  final List<TreeType> result;

  TreeTypeList({@required this.result});

  factory TreeTypeList.fromJson(List<dynamic> json) {
    List<TreeType> treeTypes = [];
    treeTypes = json.map((i) => TreeType.fromJson(i)).toList();

    return TreeTypeList(result: treeTypes);
  }
}
