// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractDetail _$ContractDetailFromJson(Map<String, dynamic> json) {
  return ContractDetail(
    id: json['id'] as int,
    contractID: json['contractID'] as int,
    startHarvest: json['startHarvest'] == null
        ? null
        : DateTime.parse(json['startHarvest'] as String),
    endHarvest: json['endHarvest'] == null
        ? null
        : DateTime.parse(json['endHarvest'] as String),
    deliveryDate: json['deliveryDate'] == null
        ? null
        : DateTime.parse(json['deliveryDate'] as String),
    yield: (json['yield'] as num)?.toDouble(),
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$ContractDetailToJson(ContractDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractID': instance.contractID,
      'startHarvest': instance.startHarvest?.toIso8601String(),
      'endHarvest': instance.endHarvest?.toIso8601String(),
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'yield': instance.yield,
      'status': instance.status,
    };
