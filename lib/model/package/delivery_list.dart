import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/package/delivery.dart';

class DeliveryList {
  final List<Delivery> result;

  DeliveryList({@required this.result});

  factory DeliveryList.fromJson(List<dynamic> json) {
    List<Delivery> list = [];
    list = json.map((i) => Delivery.fromJson(i)).toList();

    return DeliveryList(result: list);
  }
}
