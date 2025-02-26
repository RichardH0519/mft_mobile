import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/package/delivery_list.dart';
import 'package:mft_customer_side/model/package/yield_list.dart';

class PackageAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/PackageDelivery';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  PackageAPI({@required this.httpClient}) : assert(httpClient != null);

  //get remaining yield
  Future<YieldList> getRemainingYield({String username, int contractID}) async {
    final url =
        '$baseUrl/GetRemainingYield?username=$username&contractID=$contractID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get remaining yield");
    }

    final remainingYieldJson = jsonDecode(utf8.decode(response.bodyBytes));

    return YieldList.fromJson(remainingYieldJson);
  }

  //get delivery schedule
  Future<DeliveryList> getDeliverySchedule(String username) async {
    final url = '$baseUrl/GetPackageInfoByUsername/$username';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get delivery schedule");
    }

    final json = jsonDecode(utf8.decode(response.bodyBytes));

    return DeliveryList.fromJson(json);
  }
}
