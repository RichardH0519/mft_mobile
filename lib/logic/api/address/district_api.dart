import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/address/district_list.dart';

class DistrictAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/District';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  DistrictAPI({@required this.httpClient}) : assert(httpClient != null);

  Future<DistrictList> getDistricts({int cityID}) async {
    final url = '$baseUrl/$cityID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get districts");
    }

    final districtsJson = jsonDecode(utf8.decode(response.bodyBytes));

    return DistrictList.fromJson(districtsJson);
  }
}
