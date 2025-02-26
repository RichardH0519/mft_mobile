import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_exchange.g.dart';

@JsonSerializable()
class CancelExchange {
  final int requestID;
  final int responseID;
  final int managementID;

  CancelExchange({
    this.requestID,
    this.responseID,
    this.managementID,
  });

  factory CancelExchange.fromJson(Map<String, dynamic> json) =>
      _$CancelExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$CancelExchangeToJson(this);
}
