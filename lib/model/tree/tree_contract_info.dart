import 'package:json_annotation/json_annotation.dart';

part 'tree_contract_info.g.dart';

@JsonSerializable()
class TreeContractInfo {
  final String treeCode;
  final String plantTypeName;
  final int crops;
  final double yield;
  final int treePrice;
  final String description;
  final String gardenName;
  final String address;
  final String cityName;
  final String districtName;
  final String wardName;
  final String standard;
  final String image;
  final int gardenID;

  TreeContractInfo({
    this.treeCode,
    this.plantTypeName,
    this.crops,
    this.yield,
    this.treePrice,
    this.description,
    this.gardenName,
    this.address,
    this.cityName,
    this.districtName,
    this.wardName,
    this.standard,
    this.image,
    this.gardenID,
  });

  factory TreeContractInfo.fromJson(Map<String, dynamic> json) =>
      _$TreeContractInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TreeContractInfoToJson(this);
}
