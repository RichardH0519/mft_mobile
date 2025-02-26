import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plant_type.g.dart';

@JsonSerializable()
class PlantType {
  final String plantTypeName;

  PlantType({
    @required this.plantTypeName,
  });

  factory PlantType.fromJson(Map<String, dynamic> json) =>
      _$PlantTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PlantTypeToJson(this);
}
