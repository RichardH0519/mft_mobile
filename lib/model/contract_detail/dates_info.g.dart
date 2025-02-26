// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dates_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatesInfo _$DatesInfoFromJson(Map<String, dynamic> json) {
  return DatesInfo(
    startHarvest: json['startHarvest'] == null
        ? null
        : DateTime.parse(json['startHarvest'] as String),
    endHarvest: json['endHarvest'] == null
        ? null
        : DateTime.parse(json['endHarvest'] as String),
    deliveryDate: json['deliveryDate'] == null
        ? null
        : DateTime.parse(json['deliveryDate'] as String),
  );
}

Map<String, dynamic> _$DatesInfoToJson(DatesInfo instance) => <String, dynamic>{
      'startHarvest': instance.startHarvest?.toIso8601String(),
      'endHarvest': instance.endHarvest?.toIso8601String(),
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
    };
