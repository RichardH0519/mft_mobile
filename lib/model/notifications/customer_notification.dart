import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_notification.g.dart';

@JsonSerializable()
class CustomerNotification {
  final DateTime created;
  final String customer;
  final bool isSeen;
  final String title;
  final String type;

  CustomerNotification({
    @required this.created,
    @required this.customer,
    @required this.isSeen,
    @required this.title,
    @required this.type,
  });

  factory CustomerNotification.fromJson(Map<String, dynamic> json) =>
      _$CustomerNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerNotificationToJson(this);
}
