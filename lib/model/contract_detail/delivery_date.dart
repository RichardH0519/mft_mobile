import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_date.g.dart';

@JsonSerializable()
class DeliveryDate {
  final int contractID;
  final String deliveryDate;

  DeliveryDate({
    @required this.contractID,
    @required this.deliveryDate,
  });

  factory DeliveryDate.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDateFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryDateToJson(this);
}
