// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractDetailInfo _$ContractDetailInfoFromJson(Map<String, dynamic> json) {
  return ContractDetailInfo(
    cd: json['cd'] == null
        ? null
        : ContractDetail.fromJson(json['cd'] as Map<String, dynamic>),
    remainYield: (json['remainYield'] as num)?.toDouble(),
    exchangedYield: (json['exchangedYield'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ContractDetailInfoToJson(ContractDetailInfo instance) =>
    <String, dynamic>{
      'cd': instance.cd,
      'remainYield': instance.remainYield,
      'exchangedYield': instance.exchangedYield,
    };
