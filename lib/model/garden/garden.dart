import 'package:json_annotation/json_annotation.dart';

part 'garden.g.dart';

@JsonSerializable()
class Garden {
  final int id;
  final String gardenCode;
  final String gardenName;
  final String address;
  final String cityName;
  final String districtName;
  final String wardName;
  final String plantTypeName;
  final String fullname;
  final String username;

  Garden({
    this.id,
    this.gardenCode,
    this.gardenName,
    this.address,
    this.cityName,
    this.districtName,
    this.wardName,
    this.plantTypeName,
    this.fullname,
    this.username,
  });

  factory Garden.fromJson(Map<String, dynamic> json) => _$GardenFromJson(json);

  Map<String, dynamic> toJson() => _$GardenToJson(this);
}
