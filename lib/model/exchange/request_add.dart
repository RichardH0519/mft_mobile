import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_add.g.dart';

@JsonSerializable()
class RequestAdd {
  final int plantTypeID;
  final int weight;
  final int contractID;
  final String username;

  RequestAdd({
    @required this.plantTypeID,
    @required this.weight,
    @required this.contractID,
    @required this.username,
  });

  factory RequestAdd.fromJson(Map<String, dynamic> json) =>
      _$RequestAddFromJson(json);

  Map<String, dynamic> toJson() => _$RequestAddToJson(this);
}
