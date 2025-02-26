import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/plant_type/plant_type_list.dart';

class PlantTypeAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/PlantType';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  PlantTypeAPI({@required this.httpClient}) : assert(httpClient != null);

  //get all plant type
  Future<PlantTypeList> getPlantType() async {
    const url = '$baseUrl/getDistinctName';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get plant type");
    }

    final plantTypeJson = jsonDecode(utf8.decode(response.bodyBytes));

    return PlantTypeList.fromJson(plantTypeJson);
  }
}
