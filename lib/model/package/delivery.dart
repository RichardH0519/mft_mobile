import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mft_customer_side/model/package/package.dart';

part 'delivery.g.dart';

@JsonSerializable()
class Delivery {
  final Package pd;
  final DateTime deliveryDate;
  final String plantTypeName;

  Delivery({
    this.pd,
    this.deliveryDate,
    this.plantTypeName,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryToJson(this);
}
