import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree_type/tree_type_by_username.dart';

class TreeTypeByUsernameList {
  final List<TreeTypeByUsername> result;

  TreeTypeByUsernameList({@required this.result});

  factory TreeTypeByUsernameList.fromJson(List<dynamic> json) {
    List<TreeTypeByUsername> treeTypesByUsername = [];
    treeTypesByUsername =
        json.map((i) => TreeTypeByUsername.fromJson(i)).toList();

    return TreeTypeByUsernameList(result: treeTypesByUsername);
  }
}
