import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/tree/tree_api.dart';
import 'package:mft_customer_side/model/garden/garden.dart';
import 'package:mft_customer_side/model/tree/tree_list.dart';

class TreeRepo {
  final TreeAPI apiClient;

  TreeRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<TreeList> getAllTree(int id) {
    return apiClient.getTrees(
      Garden(
        id: id,
      ),
    );
  }
}
