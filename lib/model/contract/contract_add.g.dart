// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractAdd _$ContractAddFromJson(Map<String, dynamic> json) {
  return ContractAdd(
    treeID: json['treeID'] as int,
    customerUsername: json['customerUsername'] as String,
    farmerUsername: json['farmerUsername'] as String,
    numOfYear: json['numOfYear'] as int,
    totalPrice: json['totalPrice'] as int,
    totalYield: (json['totalYield'] as num)?.toDouble(),
    totalCrop: json['totalCrop'] as int,
    shipFee: json['shipFee'] as int,
  );
}

Map<String, dynamic> _$ContractAddToJson(ContractAdd instance) =>
    <String, dynamic>{
      'treeID': instance.treeID,
      'customerUsername': instance.customerUsername,
      'farmerUsername': instance.farmerUsername,
      'numOfYear': instance.numOfYear,
      'totalPrice': instance.totalPrice,
      'totalYield': instance.totalYield,
      'totalCrop': instance.totalCrop,
      'shipFee': instance.shipFee,
    };
