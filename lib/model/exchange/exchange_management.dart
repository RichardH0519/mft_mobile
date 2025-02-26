import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange_management.g.dart';

@JsonSerializable()
class ExchangeManagement {
  final int id;
  final int requestID;
  final int responseID;
  final bool requestReceived;
  final bool responseReceived;
  final int status;

  ExchangeManagement({
    @required this.id,
    @required this.requestID,
    @required this.responseID,
    @required this.requestReceived,
    @required this.responseReceived,
    @required this.status,
  });

  factory ExchangeManagement.fromJson(Map<String, dynamic> json) =>
      _$ExchangeManagementFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeManagementToJson(this);
}
