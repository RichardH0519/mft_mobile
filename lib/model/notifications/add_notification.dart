import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_notification.g.dart';

@JsonSerializable()
class AddNotification {
  final DateTime created;
  final String farmer;
  final bool isSeen;
  final String title;
  final String type;
  final int contractNumber;

  AddNotification({
    @required this.created,
    @required this.farmer,
    @required this.isSeen,
    @required this.title,
    @required this.type,
    this.contractNumber,
  });

  factory AddNotification.fromJson(Map<String, dynamic> json) =>
      _$AddNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$AddNotificationToJson(this);
}
