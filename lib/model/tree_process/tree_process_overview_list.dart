import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree_process/tree_process_overview.dart';
import 'package:mft_customer_side/model/tree_type/tree_type.dart';

class TreeProcessOverviewList {
  final List<TreeProcessOverview> result;

  TreeProcessOverviewList({@required this.result});

  factory TreeProcessOverviewList.fromJson(List<dynamic> json) {
    List<TreeProcessOverview> treeProcesses = [];
    treeProcesses = json.map((i) => TreeProcessOverview.fromJson(i)).toList();

    return TreeProcessOverviewList(result: treeProcesses);
  }
}
