import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_interest_delete.g.dart';

@JsonSerializable()
class UserInterestDelete {
  final int id;

  UserInterestDelete({
    @required this.id,
  });

  factory UserInterestDelete.fromJson(Map<String, dynamic> json) =>
      _$UserInterestDeleteFromJson(json);

  Map<String, dynamic> toJson() => _$UserInterestDeleteToJson(this);
}
