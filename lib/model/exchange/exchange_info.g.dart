// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeInfo _$ExchangeInfoFromJson(Map<String, dynamic> json) {
  return ExchangeInfo(
    mag: json['mag'] == null
        ? null
        : ExchangeManagement.fromJson(json['mag'] as Map<String, dynamic>),
    requestFullname: json['requestFullname'] as String,
    requestUsername: json['requestUsername'] as String,
    responseFullname: json['responseFullname'] as String,
    responseUsername: json['responseUsername'] as String,
    requestWeight: json['requestWeight'] as int,
    weight: json['weight'] as int,
    responsePlant: json['responsePlant'] as String,
    requestPlant: json['requestPlant'] as String,
    requestPhone: json['requestPhone'] as String,
    responsePhone: json['responsePhone'] as String,
  );
}

Map<String, dynamic> _$ExchangeInfoToJson(ExchangeInfo instance) =>
    <String, dynamic>{
      'mag': instance.mag,
      'requestFullname': instance.requestFullname,
      'requestUsername': instance.requestUsername,
      'responseFullname': instance.responseFullname,
      'responseUsername': instance.responseUsername,
      'requestWeight': instance.requestWeight,
      'weight': instance.weight,
      'responsePlant': instance.responsePlant,
      'requestPlant': instance.requestPlant,
      'requestPhone': instance.requestPhone,
      'responsePhone': instance.responsePhone,
    };
