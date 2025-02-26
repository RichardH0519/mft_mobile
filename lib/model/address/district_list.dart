import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/address/district.dart';
import 'package:mft_customer_side/model/address/ward.dart';

class DistrictList {
  final List<District> result;

  DistrictList({@required this.result});

  factory DistrictList.fromJson(List<dynamic> json) {
    List<District> districts = [];
    districts = json.map((i) => District.fromJson(i)).toList();

    return DistrictList(result: districts);
  }
}
