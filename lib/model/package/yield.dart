import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'yield.g.dart';

@JsonSerializable()
class Yield {
  final double yield;

  Yield({
    @required this.yield,
  });

  factory Yield.fromJson(Map<String, dynamic> json) => _$YieldFromJson(json);

  Map<String, dynamic> toJson() => _$YieldToJson(this);
}
