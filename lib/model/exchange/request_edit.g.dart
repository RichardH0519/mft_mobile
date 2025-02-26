// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestEdit _$RequestEditFromJson(Map<String, dynamic> json) {
  return RequestEdit(
    requestID: json['requestID'] as int,
    weight: json['weight'] as int,
  );
}

Map<String, dynamic> _$RequestEditToJson(RequestEdit instance) =>
    <String, dynamic>{
      'requestID': instance.requestID,
      'weight': instance.weight,
    };
