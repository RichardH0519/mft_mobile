import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_edit.g.dart';

@JsonSerializable()
class ResponseEdit {
  final int responseID;
  final int weight;
  final int contractID;
  final int requestWeight;

  ResponseEdit({
    @required this.responseID,
    @required this.weight,
    @required this.contractID,
    @required this.requestWeight,
  });

  factory ResponseEdit.fromJson(Map<String, dynamic> json) =>
      _$ResponseEditFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseEditToJson(this);
}
