import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/plant_type/plant_type_api.dart';
import 'package:mft_customer_side/model/plant_type/plant_type_list.dart';

class PlantTypeRepo {
  final PlantTypeAPI apiClient;

  PlantTypeRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<PlantTypeList> getPlantType() {
    return apiClient.getPlantType();
  }
}
