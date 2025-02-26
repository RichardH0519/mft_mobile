import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accept_exchange.g.dart';

@JsonSerializable()
class AcceptExchange {
  final int requestID;
  final int responseID;

  AcceptExchange({
    @required this.requestID,
    @required this.responseID,
  });

  factory AcceptExchange.fromJson(Map<String, dynamic> json) =>
      _$AcceptExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptExchangeToJson(this);
}
