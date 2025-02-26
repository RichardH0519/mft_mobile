// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_type_by_username.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeTypeByUsername _$TreeTypeByUsernameFromJson(Map<String, dynamic> json) {
  return TreeTypeByUsername(
    it: json['it'] == null
        ? null
        : UserInterest.fromJson(json['it'] as Map<String, dynamic>),
    typeName: json['typeName'] as String,
  );
}

Map<String, dynamic> _$TreeTypeByUsernameToJson(TreeTypeByUsername instance) =>
    <String, dynamic>{
      'it': instance.it,
      'typeName': instance.typeName,
    };
