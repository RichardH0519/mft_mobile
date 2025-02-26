import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/garden/garden_list.dart';
import 'package:mft_customer_side/model/plant_type/plant_type.dart';
import 'package:mft_customer_side/model/user/user.dart';

class GardenAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/Garden';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  GardenAPI({@required this.httpClient}) : assert(httpClient != null);

  //get all active garden
  Future<GardenList> getGardens() async {
    final url = '$baseUrl/getActiveGarden';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all garden");
    }

    final gardenJson = jsonDecode(utf8.decode(response.bodyBytes));

    return GardenList.fromJson(gardenJson);
  }

  //get all active garden by interest
  Future<GardenList> getGardensByInterest(User user) async {
    final url = '$baseUrl/getFromInterest/${user.username}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all garden by interest");
    }

    final gardenJson = jsonDecode(utf8.decode(response.bodyBytes));

    return GardenList.fromJson(gardenJson);
  }

  //get garden by plant type
  Future<GardenList> getGardensByPlantType(PlantType plantType) async {
    final url = '$baseUrl/search/${plantType.plantTypeName}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all garden by plant type");
    }

    final gardenJson = jsonDecode(utf8.decode(response.bodyBytes));

    return GardenList.fromJson(gardenJson);
  }
}
