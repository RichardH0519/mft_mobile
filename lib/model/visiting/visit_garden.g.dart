// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_garden.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitGarden _$VisitGardenFromJson(Map<String, dynamic> json) {
  return VisitGarden(
    visitDate: json['visitDate'] as String,
    customerUsername: json['customerUsername'] as String,
    gardenID: json['gardenID'] as int,
  );
}

Map<String, dynamic> _$VisitGardenToJson(VisitGarden instance) =>
    <String, dynamic>{
      'visitDate': instance.visitDate,
      'customerUsername': instance.customerUsername,
      'gardenID': instance.gardenID,
    };
