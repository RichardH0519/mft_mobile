// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeProcess _$TreeProcessFromJson(Map<String, dynamic> json) {
  return TreeProcess(
    id: json['id'] as int,
    treeID: json['treeID'] as int,
    contractID: json['contractID'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    processImage: json['processImage'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$TreeProcessToJson(TreeProcess instance) =>
    <String, dynamic>{
      'id': instance.id,
      'treeID': instance.treeID,
      'contractID': instance.contractID,
      'date': instance.date?.toIso8601String(),
      'processImage': instance.processImage,
      'description': instance.description,
    };
