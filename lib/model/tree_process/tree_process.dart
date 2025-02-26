import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tree_process.g.dart';

@JsonSerializable()
class TreeProcess {
  final int id;
  final int treeID;
  final int contractID;
  final DateTime date;
  final String processImage;
  final String description;

  TreeProcess({
    this.id,
    this.treeID,
    this.contractID,
    this.date,
    this.processImage,
    this.description,
  });

  factory TreeProcess.fromJson(Map<String, dynamic> json) =>
      _$TreeProcessFromJson(json);

  Map<String, dynamic> toJson() => _$TreeProcessToJson(this);
}
