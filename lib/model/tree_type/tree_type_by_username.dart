import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mft_customer_side/model/user/user_interest.dart';

part 'tree_type_by_username.g.dart';

@JsonSerializable()
class TreeTypeByUsername {
  final UserInterest it;
  final String typeName;

  TreeTypeByUsername({
    @required this.it,
    @required this.typeName,
  });

  factory TreeTypeByUsername.fromJson(Map<String, dynamic> json) =>
      _$TreeTypeByUsernameFromJson(json);

  Map<String, dynamic> toJson() => _$TreeTypeByUsernameToJson(this);
}
