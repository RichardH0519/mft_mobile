// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ward _$WardFromJson(Map<String, dynamic> json) {
  return Ward(
    id: json['id'] as int,
    wardName: json['wardName'] as String,
  );
}

Map<String, dynamic> _$WardToJson(Ward instance) => <String, dynamic>{
      'id': instance.id,
      'wardName': instance.wardName,
    };
