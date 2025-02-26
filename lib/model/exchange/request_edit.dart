import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_edit.g.dart';

@JsonSerializable()
class RequestEdit {
  final int requestID;
  final int weight;

  RequestEdit({
    @required this.requestID,
    @required this.weight,
  });

  factory RequestEdit.fromJson(Map<String, dynamic> json) =>
      _$RequestEditFromJson(json);

  Map<String, dynamic> toJson() => _$RequestEditToJson(this);
}
