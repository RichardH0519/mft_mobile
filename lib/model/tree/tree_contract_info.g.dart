// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_contract_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeContractInfo _$TreeContractInfoFromJson(Map<String, dynamic> json) {
  return TreeContractInfo(
    treeCode: json['treeCode'] as String,
    plantTypeName: json['plantTypeName'] as String,
    crops: json['crops'] as int,
    yield: (json['yield'] as num)?.toDouble(),
    treePrice: json['treePrice'] as int,
    description: json['description'] as String,
    gardenName: json['gardenName'] as String,
    address: json['address'] as String,
    cityName: json['cityName'] as String,
    districtName: json['districtName'] as String,
    wardName: json['wardName'] as String,
    standard: json['standard'] as String,
    image: json['image'] as String,
    gardenID: json['gardenID'] as int,
  );
}

Map<String, dynamic> _$TreeContractInfoToJson(TreeContractInfo instance) =>
    <String, dynamic>{
      'treeCode': instance.treeCode,
      'plantTypeName': instance.plantTypeName,
      'crops': instance.crops,
      'yield': instance.yield,
      'treePrice': instance.treePrice,
      'description': instance.description,
      'gardenName': instance.gardenName,
      'address': instance.address,
      'cityName': instance.cityName,
      'districtName': instance.districtName,
      'wardName': instance.wardName,
      'standard': instance.standard,
      'image': instance.image,
      'gardenID': instance.gardenID,
    };
