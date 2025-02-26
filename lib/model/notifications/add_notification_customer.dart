import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_notification_customer.g.dart';

@JsonSerializable()
class AddNotificationCustomer {
  final DateTime created;
  final String customer;
  final bool isSeen;
  final String title;
  final String type;

  AddNotificationCustomer({
    @required this.created,
    @required this.customer,
    @required this.isSeen,
    @required this.title,
    @required this.type,
    
  });

  factory AddNotificationCustomer.fromJson(Map<String, dynamic> json) =>
      _$AddNotificationCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$AddNotificationCustomerToJson(this);
}
