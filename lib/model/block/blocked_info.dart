import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mft_customer_side/model/block/blocked.dart';

part 'blocked_info.g.dart';

@JsonSerializable()
class BlockedInfo {
  final Blocked b;
  final String fullname;

  BlockedInfo({@required this.b, @required this.fullname});

  factory BlockedInfo.fromJson(Map<String, dynamic> json) =>
      _$BlockedInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BlockedInfoToJson(this);
}
