import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable()
class CustomerFeedback {
  final String customerUsername;
  final String farmerUsername;
  final String feedback;

  CustomerFeedback({
    @required this.customerUsername,
    @required this.farmerUsername,
    @required this.feedback,
  });

  factory CustomerFeedback.fromJson(Map<String, dynamic> json) =>
      _$CustomerFeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerFeedbackToJson(this);
}
