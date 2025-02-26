// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) {
  return Package(
    id: json['id'] as int,
    username: json['username'] as String,
    yield: (json['yield'] as num)?.toDouble(),
    contractDetailID: json['contractDetailID'] as int,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'yield': instance.yield,
      'contractDetailID': instance.contractDetailID,
      'status': instance.status,
    };
