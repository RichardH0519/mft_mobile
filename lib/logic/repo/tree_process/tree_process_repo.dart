import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/tree_process/tree_process_api.dart';
import 'package:mft_customer_side/model/tree_process/tree_process_overview_list.dart';

class TreeProcessRepo {
  final TreeProcessAPI apiClient;

  TreeProcessRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<TreeProcessOverviewList> getTreeProcess(int contractID) {
    return apiClient.getTreeProcess(contractID);
  }
}
