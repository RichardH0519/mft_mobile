// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerNotification _$CustomerNotificationFromJson(Map<String, dynamic> json) {
  return CustomerNotification(
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    customer: json['customer'] as String,
    isSeen: json['isSeen'] as bool,
    title: json['title'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$CustomerNotificationToJson(
        CustomerNotification instance) =>
    <String, dynamic>{
      'created': instance.created?.toIso8601String(),
      'customer': instance.customer,
      'isSeen': instance.isSeen,
      'title': instance.title,
      'type': instance.type,
    };
