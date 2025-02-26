import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';

@JsonSerializable()
class Ward {
  final int id;
  final String wardName;

  Ward({
    @required this.id,
    @required this.wardName,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);

  Map<String, dynamic> toJson() => _$WardToJson(this);
}
