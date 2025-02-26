import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/garden/garden_api.dart';
import 'package:mft_customer_side/model/garden/garden_list.dart';
import 'package:mft_customer_side/model/plant_type/plant_type.dart';
import 'package:mft_customer_side/model/user/user.dart';

class GardenRepo {
  final GardenAPI apiClient;

  GardenRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<GardenList> getAllActiveGarden() {
    return apiClient.getGardens();
  }

  Future<GardenList> getAllActiveGardenByInteret(String username) {
    return apiClient.getGardensByInterest(
      User(
        username: username,
      ),
    );
  }

  Future<GardenList> getAllActiveGardenByPlantType(String plantTypeName) {
    return apiClient.getGardensByPlantType(
      PlantType(plantTypeName: plantTypeName),
    );
  }
}
