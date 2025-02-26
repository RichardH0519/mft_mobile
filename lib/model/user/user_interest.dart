import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_interest.g.dart';

@JsonSerializable()
class UserInterest {
  final int id;
  final String username;
  final int treeTypeID;

  UserInterest({
    @required this.id,
    @required this.username,
    @required this.treeTypeID,
  });

  factory UserInterest.fromJson(Map<String, dynamic> json) =>
      _$UserInterestFromJson(json);

  Map<String, dynamic> toJson() => _$UserInterestToJson(this);
}