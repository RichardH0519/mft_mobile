import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mft_customer_side/model/visiting/visit.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  final Visit v;
  final String gardenName;
  final String phone;

  Schedule({
    this.v,
    this.gardenName,
    this.phone,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
