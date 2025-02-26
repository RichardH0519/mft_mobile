import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mft_customer_side/model/tree_process/tree_process.dart';

part 'tree_process_overview.g.dart';

@JsonSerializable()
class TreeProcessOverview {
  final TreeProcess tp;

  TreeProcessOverview({
    this.tp,
  });

  factory TreeProcessOverview.fromJson(Map<String, dynamic> json) =>
      _$TreeProcessOverviewFromJson(json);

  Map<String, dynamic> toJson() => _$TreeProcessOverviewToJson(this);
}
