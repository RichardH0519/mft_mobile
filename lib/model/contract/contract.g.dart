// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) {
  return Contract(
    contractID: json['contractID'] as int,
    contractNumber: json['contractNumber'] as int,
    treeID: json['treeID'] as int,
    treePrice: json['treePrice'] as int,
    customerUsername: json['customerUsername'] as String,
    farmerUsername: json['farmerUsername'] as String,
    numOfYear: json['numOfYear'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    shipFee: json['shipFee'] as int,
    totalPrice: json['totalPrice'] as int,
    contractPrice: json['contractPrice'] as int,
    totalCrop: json['totalCrop'] as int,
    cancelParty: json['cancelParty'] as String,
    cancelReason: json['cancelReason'] as String,
    refund: json['refund'] as int,
    totalYield: (json['totalYield'] as num)?.toDouble(),
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'contractID': instance.contractID,
      'contractNumber': instance.contractNumber,
      'treeID': instance.treeID,
      'treePrice': instance.treePrice,
      'customerUsername': instance.customerUsername,
      'farmerUsername': instance.farmerUsername,
      'numOfYear': instance.numOfYear,
      'date': instance.date?.toIso8601String(),
      'shipFee': instance.shipFee,
      'totalPrice': instance.totalPrice,
      'contractPrice': instance.contractPrice,
      'totalCrop': instance.totalCrop,
      'cancelParty': instance.cancelParty,
      'cancelReason': instance.cancelReason,
      'refund': instance.refund,
      'totalYield': instance.totalYield,
      'status': instance.status,
    };
