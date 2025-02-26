import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/plant_type/plant_type.dart';

class PlantTypeList {
  final List<PlantType> result;

  PlantTypeList({@required this.result});

  factory PlantTypeList.fromJson(List<dynamic> json) {
    List<PlantType> plantTypes = [];
    plantTypes = json.map((i) => PlantType.fromJson(i)).toList();

    return PlantTypeList(result: plantTypes);
  }
}
