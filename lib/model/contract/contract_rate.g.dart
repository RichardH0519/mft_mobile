// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractRate _$ContractRateFromJson(Map<String, dynamic> json) {
  return ContractRate(
    totalYield: (json['totalYield'] as num)?.toDouble(),
    totalPrice: json['totalPrice'] as int,
  );
}

Map<String, dynamic> _$ContractRateToJson(ContractRate instance) =>
    <String, dynamic>{
      'totalYield': instance.totalYield,
      'totalPrice': instance.totalPrice,
    };
