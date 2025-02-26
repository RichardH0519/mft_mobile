// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Garden _$GardenFromJson(Map<String, dynamic> json) {
  return Garden(
    id: json['id'] as int,
    gardenCode: json['gardenCode'] as String,
    gardenName: json['gardenName'] as String,
    address: json['address'] as String,
    cityName: json['cityName'] as String,
    districtName: json['districtName'] as String,
    wardName: json['wardName'] as String,
    plantTypeName: json['plantTypeName'] as String,
    fullname: json['fullname'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$GardenToJson(Garden instance) => <String, dynamic>{
      'id': instance.id,
      'gardenCode': instance.gardenCode,
      'gardenName': instance.gardenName,
      'address': instance.address,
      'cityName': instance.cityName,
      'districtName': instance.districtName,
      'wardName': instance.wardName,
      'plantTypeName': instance.plantTypeName,
      'fullname': instance.fullname,
      'username': instance.username,
    };
