import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tree_type.g.dart';

@JsonSerializable()
class TreeType {
  final int id;
  final String typeName;

  TreeType({
    @required this.id,
    @required this.typeName,
  });

  factory TreeType.fromJson(Map<String, dynamic> json) => _$TreeTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TreeTypeToJson(this);
}
