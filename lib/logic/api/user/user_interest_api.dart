import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/user/user_interest.dart';
import 'package:mft_customer_side/model/user/user_interest_delete.dart';

class UserInterestAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/InterestedTreeType';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  UserInterestAPI({@required this.httpClient}) : assert(httpClient != null);

  //delete user interested tree type
  Future<bool> deleteByID(UserInterestDelete interest) async {
    final url = '$baseUrl/${interest.id}';
    var status = false;

    final response = await httpClient.delete(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to delete interest");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //update user interested tree type
  Future<bool> updateInterest(UserInterest user) async {
    final url = '$baseUrl/UpdateInterestedTreeType';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(user.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to update");
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
