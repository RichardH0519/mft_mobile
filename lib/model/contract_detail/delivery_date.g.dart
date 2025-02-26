// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryDate _$DeliveryDateFromJson(Map<String, dynamic> json) {
  return DeliveryDate(
    contractID: json['contractID'] as int,
    deliveryDate: json['deliveryDate'] as String,
  );
}

Map<String, dynamic> _$DeliveryDateToJson(DeliveryDate instance) =>
    <String, dynamic>{
      'contractID': instance.contractID,
      'deliveryDate': instance.deliveryDate,
    };
