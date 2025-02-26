import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit_garden.g.dart';

@JsonSerializable()
class VisitGarden {
  final String visitDate;
  final String customerUsername;
  final int gardenID;

  VisitGarden({
    @required this.visitDate,
    @required this.customerUsername,
    @required this.gardenID,
  });

  factory VisitGarden.fromJson(Map<String, dynamic> json) =>
      _$VisitGardenFromJson(json);

  Map<String, dynamic> toJson() => _$VisitGardenToJson(this);
}
