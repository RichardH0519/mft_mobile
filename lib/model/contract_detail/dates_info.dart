import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dates_info.g.dart';

@JsonSerializable()
class DatesInfo {
  final DateTime startHarvest;
  final DateTime endHarvest;
  final DateTime deliveryDate;

  DatesInfo({
    @required this.startHarvest,
    @required this.endHarvest,
    @required this.deliveryDate,
  });

  factory DatesInfo.fromJson(Map<String, dynamic> json) =>
      _$DatesInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DatesInfoToJson(this);
}
