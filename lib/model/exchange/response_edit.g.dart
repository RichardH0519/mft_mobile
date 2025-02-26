// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseEdit _$ResponseEditFromJson(Map<String, dynamic> json) {
  return ResponseEdit(
    responseID: json['responseID'] as int,
    weight: json['weight'] as int,
    contractID: json['contractID'] as int,
    requestWeight: json['requestWeight'] as int,
  );
}

Map<String, dynamic> _$ResponseEditToJson(ResponseEdit instance) =>
    <String, dynamic>{
      'responseID': instance.responseID,
      'weight': instance.weight,
      'contractID': instance.contractID,
      'requestWeight': instance.requestWeight,
    };
