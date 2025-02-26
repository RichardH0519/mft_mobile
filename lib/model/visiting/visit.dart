import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit.g.dart';

@JsonSerializable()
class Visit {
  final int id;
  final DateTime visitDate;
  final String customerUsername;
  final int gardenID;
  final int status;

  Visit({
    this.id,
    this.visitDate,
    this.customerUsername,
    this.gardenID,
    this.status,
  });

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);

  Map<String, dynamic> toJson() => _$VisitToJson(this);
}
