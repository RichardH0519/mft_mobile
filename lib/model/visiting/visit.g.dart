// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Visit _$VisitFromJson(Map<String, dynamic> json) {
  return Visit(
    id: json['id'] as int,
    visitDate: json['visitDate'] == null
        ? null
        : DateTime.parse(json['visitDate'] as String),
    customerUsername: json['customerUsername'] as String,
    gardenID: json['gardenID'] as int,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'id': instance.id,
      'visitDate': instance.visitDate?.toIso8601String(),
      'customerUsername': instance.customerUsername,
      'gardenID': instance.gardenID,
      'status': instance.status,
    };
