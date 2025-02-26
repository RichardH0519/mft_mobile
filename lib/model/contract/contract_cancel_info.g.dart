// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_cancel_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractCancelInfo _$ContractCancelInfoFromJson(Map<String, dynamic> json) {
  return ContractCancelInfo(
    cancelPartyName: json['cancelPartyName'] as String,
    cancelReason: json['cancelReason'] as String,
    cancelDate: json['cancelDate'] == null
        ? null
        : DateTime.parse(json['cancelDate'] as String),
    refund: json['refund'] as int,
  );
}

Map<String, dynamic> _$ContractCancelInfoToJson(ContractCancelInfo instance) =>
    <String, dynamic>{
      'cancelPartyName': instance.cancelPartyName,
      'cancelReason': instance.cancelReason,
      'cancelDate': instance.cancelDate?.toIso8601String(),
      'refund': instance.refund,
    };
