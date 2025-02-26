import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/address/ward.dart';

class WardList {
  final List<Ward> result;

  WardList({@required this.result});

  factory WardList.fromJson(List<dynamic> json) {
    List<Ward> wards = [];
    wards = json.map((i) => Ward.fromJson(i)).toList();

    return WardList(result: wards);
  }
}
