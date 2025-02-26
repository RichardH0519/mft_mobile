// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractOverview _$ContractOverviewFromJson(Map<String, dynamic> json) {
  return ContractOverview(
    id: json['id'] as int,
    treeCode: json['treeCode'] as String,
    plantTypeName: json['plantTypeName'] as String,
    gardenName: json['gardenName'] as String,
    fullname: json['fullname'] as String,
    status: json['status'] as int,
    contractID: json['contractID'] as int,
    plantTypeID: json['plantTypeID'] as int,
    totalPrice: json['totalPrice'] as int,
    totalYield: (json['totalYield'] as num)?.toDouble(),
    cancelParty: json['cancelParty'] as String,
    contractNumber: json['contractNumber'] as int,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$ContractOverviewToJson(ContractOverview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'treeCode': instance.treeCode,
      'plantTypeName': instance.plantTypeName,
      'gardenName': instance.gardenName,
      'fullname': instance.fullname,
      'status': instance.status,
      'contractID': instance.contractID,
      'plantTypeID': instance.plantTypeID,
      'totalPrice': instance.totalPrice,
      'totalYield': instance.totalYield,
      'cancelParty': instance.cancelParty,
      'contractNumber': instance.contractNumber,
      'username': instance.username,
    };
