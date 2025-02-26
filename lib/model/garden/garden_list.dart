import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/garden/garden.dart';

class GardenList {
  final List<Garden> result;

  GardenList({@required this.result});

  factory GardenList.fromJson(List<dynamic> json) {
    List<Garden> gardens = [];
    gardens = json.map((i) => Garden.fromJson(i)).toList();

    return GardenList(result: gardens);
  }
}
