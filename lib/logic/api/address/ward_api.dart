import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/address/ward_list.dart';

class WardAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/Ward';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  WardAPI({@required this.httpClient}) : assert(httpClient != null);

  Future<WardList> getWardsByDistrict({int districtID}) async {
    final url = '$baseUrl/$districtID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get wards");
    }

    final wardsJson = jsonDecode(utf8.decode(response.bodyBytes));

    return WardList.fromJson(wardsJson);
  }
}
