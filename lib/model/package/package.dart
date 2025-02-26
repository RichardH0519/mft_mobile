import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable()
class Package {
  final int id;
  final String username;
  final double yield;
  final int contractDetailID;
  final int status;

  Package({
    this.id,
    this.username,
    this.yield,
    this.contractDetailID,
    this.status,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
