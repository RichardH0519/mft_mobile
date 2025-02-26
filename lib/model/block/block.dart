import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'block.g.dart';

@JsonSerializable()
class Block {
  final String username;
  final String blocked;

  Block({
    @required this.username,
    @required this.blocked,
  });

  factory Block.fromJson(Map<String, dynamic> json) =>
      _$BlockFromJson(json);

  Map<String, dynamic> toJson() => _$BlockToJson(this);
}
