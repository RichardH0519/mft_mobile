import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/tree_type/tree_type_api.dart';
import 'package:mft_customer_side/model/tree_type/tree_type_list.dart';

class TreeTypeRepo {
  final TreeTypeAPI apiClient;

  TreeTypeRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<TreeTypeList> getTreeType(){
    return apiClient.getTreeType();
  }
}
