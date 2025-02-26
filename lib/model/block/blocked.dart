import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blocked.g.dart';

@JsonSerializable()
class Blocked {
  final int id;
  final String username;
  final String blocked;

  Blocked({
    @required this.id,
    @required this.username,
    @required this.blocked,
  });

  factory Blocked.fromJson(Map<String, dynamic> json) =>
      _$BlockedFromJson(json);

  Map<String, dynamic> toJson() => _$BlockedToJson(this);
}
