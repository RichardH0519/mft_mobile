// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Delivery _$DeliveryFromJson(Map<String, dynamic> json) {
  return Delivery(
    pd: json['pd'] == null
        ? null
        : Package.fromJson(json['pd'] as Map<String, dynamic>),
    deliveryDate: json['deliveryDate'] == null
        ? null
        : DateTime.parse(json['deliveryDate'] as String),
    plantTypeName: json['plantTypeName'] as String,
  );
}

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => <String, dynamic>{
      'pd': instance.pd,
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'plantTypeName': instance.plantTypeName,
    };
