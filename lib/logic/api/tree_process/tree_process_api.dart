import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/tree_process/tree_process_overview_list.dart';

class TreeProcessAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/TreeProcess';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  TreeProcessAPI({@required this.httpClient}) : assert(httpClient != null);

  //get all tree process
  Future<TreeProcessOverviewList> getTreeProcess(int contractID) async {
    final url = '$baseUrl/AppGetTreeProcessByContractID/$contractID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get tree process");
    }

    final treeProcessJson = jsonDecode(utf8.decode(response.bodyBytes));

    return TreeProcessOverviewList.fromJson(treeProcessJson);
  }
}
