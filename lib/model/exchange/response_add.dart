import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_add.g.dart';

@JsonSerializable()
class ResponseAdd {
  final int exchangeRequestID;
  final int weight;
  final int contractID;
  final String username;
  final int requestWeight;

  ResponseAdd({
    @required this.exchangeRequestID,
    @required this.weight,
    @required this.contractID,
    @required this.username,
    @required this.requestWeight,
  });

  factory ResponseAdd.fromJson(Map<String, dynamic> json) =>
      _$ResponseAddFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseAddToJson(this);
}
