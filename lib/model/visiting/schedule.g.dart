// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    v: json['v'] == null
        ? null
        : Visit.fromJson(json['v'] as Map<String, dynamic>),
    gardenName: json['gardenName'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'v': instance.v,
      'gardenName': instance.gardenName,
      'phone': instance.phone,
    };
