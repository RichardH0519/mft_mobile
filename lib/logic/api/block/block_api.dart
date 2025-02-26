import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/block/block.dart';
import 'package:mft_customer_side/model/block/blocked_list.dart';

class BlockAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/Block';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  BlockAPI({@required this.httpClient}) : assert(httpClient != null);

  //block a user
  Future<bool> block(Block block) async {
    final url = '$baseUrl/AddBlock';
    var status = false;

    final response = await httpClient.post(url,
        headers: headers, body: json.encode(block.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to block");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //get blocked list
  Future<BlockedList> getBlockedList(String username) async {
    final url = '$baseUrl/GetAllBlockFromUsername/$username';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get blocked list");
    }

    final json = jsonDecode(utf8.decode(response.bodyBytes));

    return BlockedList.fromJson(json);
  }

  //unblock
  Future<bool> unblock(int id) async {
    final url = '$baseUrl/DeleteBlock/$id';
    var status = false;

    final response = await httpClient.delete(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to unblock");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }
}
