// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInterest _$UserInterestFromJson(Map<String, dynamic> json) {
  return UserInterest(
    id: json['id'] as int,
    username: json['username'] as String,
    treeTypeID: json['treeTypeID'] as int,
  );
}

Map<String, dynamic> _$UserInterestToJson(UserInterest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'treeTypeID': instance.treeTypeID,
    };
