import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree/tree.dart';

class TreeList {
  final List<Tree> result;

  TreeList({@required this.result});

  factory TreeList.fromJson(List<dynamic> json) {
    List<Tree> trees = [];
    trees = json.map((i) => Tree.fromJson(i)).toList();

    return TreeList(result: trees);
  }
}
