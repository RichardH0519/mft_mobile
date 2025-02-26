// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNotification _$AddNotificationFromJson(Map<String, dynamic> json) {
  return AddNotification(
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    farmer: json['farmer'] as String,
    isSeen: json['isSeen'] as bool,
    title: json['title'] as String,
    type: json['type'] as String,
    contractNumber: json['contractNumber'] as int,
  );
}

Map<String, dynamic> _$AddNotificationToJson(AddNotification instance) =>
    <String, dynamic>{
      'created': instance.created?.toIso8601String(),
      'farmer': instance.farmer,
      'isSeen': instance.isSeen,
      'title': instance.title,
      'type': instance.type,
      'contractNumber': instance.contractNumber,
    };
