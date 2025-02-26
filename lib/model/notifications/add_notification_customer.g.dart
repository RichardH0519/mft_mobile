// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_notification_customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNotificationCustomer _$AddNotificationCustomerFromJson(
    Map<String, dynamic> json) {
  return AddNotificationCustomer(
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    customer: json['customer'] as String,
    isSeen: json['isSeen'] as bool,
    title: json['title'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$AddNotificationCustomerToJson(
        AddNotificationCustomer instance) =>
    <String, dynamic>{
      'created': instance.created?.toIso8601String(),
      'customer': instance.customer,
      'isSeen': instance.isSeen,
      'title': instance.title,
      'type': instance.type,
    };
