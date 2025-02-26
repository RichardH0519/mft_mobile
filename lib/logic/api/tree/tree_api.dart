import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/garden/garden.dart';
import 'package:mft_customer_side/model/tree/tree_list.dart';

class TreeAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/Tree';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  TreeAPI({@required this.httpClient}) : assert(httpClient != null);

  //get tree from garden with gardenID
  Future<TreeList> getTrees(Garden garden) async {
    final url = '$baseUrl/getTreeFromGarden/${garden.id}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all tree");
    }

    final treeJson = jsonDecode(utf8.decode(response.bodyBytes));

    return TreeList.fromJson(treeJson);
  }
}
