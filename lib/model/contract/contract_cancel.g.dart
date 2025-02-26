// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_cancel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractCancel _$ContractCancelFromJson(Map<String, dynamic> json) {
  return ContractCancel(
    contractID: json['contractID'] as int,
    cancelParty: json['cancelParty'] as String,
    cancelReason: json['cancelReason'] as String,
    refund: json['refund'] as int,
  );
}

Map<String, dynamic> _$ContractCancelToJson(ContractCancel instance) =>
    <String, dynamic>{
      'contractID': instance.contractID,
      'cancelParty': instance.cancelParty,
      'cancelReason': instance.cancelReason,
      'refund': instance.refund,
    };
