// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeInfo _$TreeInfoFromJson(Map<String, dynamic> json) {
  return TreeInfo(
    treeCode: json['treeCode'] as String,
    plantTypeName: json['plantTypeName'] as String,
    gardenName: json['gardenName'] as String,
    address: json['address'] as String,
    cityName: json['cityName'] as String,
    districtName: json['districtName'] as String,
    wardName: json['wardName'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$TreeInfoToJson(TreeInfo instance) => <String, dynamic>{
      'treeCode': instance.treeCode,
      'plantTypeName': instance.plantTypeName,
      'gardenName': instance.gardenName,
      'address': instance.address,
      'cityName': instance.cityName,
      'districtName': instance.districtName,
      'wardName': instance.wardName,
      'phone': instance.phone,
      'email': instance.email,
      'image': instance.image,
    };
