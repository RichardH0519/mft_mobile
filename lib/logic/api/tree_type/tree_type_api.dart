import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/tree_type/tree_type_list.dart';

class TreeTypeAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/TreeType';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  TreeTypeAPI({@required this.httpClient}) : assert(httpClient != null);

  //get all tree type
  Future<TreeTypeList> getTreeType() async {
    const url = '$baseUrl';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get tree type");
    }

    final treeTypeJson = jsonDecode(utf8.decode(response.bodyBytes));

    return TreeTypeList.fromJson(treeTypeJson);
  }
}
