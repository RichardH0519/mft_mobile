import 'package:json_annotation/json_annotation.dart';

part 'tree_info.g.dart';

@JsonSerializable()
class TreeInfo {
  final String treeCode;
  final String plantTypeName;
  final String gardenName;
  final String address;
  final String cityName;
  final String districtName;
  final String wardName;
  final String phone;
  final String email;
  final String image;

  TreeInfo({
    this.treeCode,
    this.plantTypeName,
    this.gardenName,
    this.address,
    this.cityName,
    this.districtName,
    this.wardName,
    this.phone,
    this.email,
    this.image,
  });

  factory TreeInfo.fromJson(Map<String, dynamic> json) =>
      _$TreeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TreeInfoToJson(this);
}
