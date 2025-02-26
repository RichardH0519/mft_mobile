// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_process_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeProcessOverview _$TreeProcessOverviewFromJson(Map<String, dynamic> json) {
  return TreeProcessOverview(
    tp: json['tp'] == null
        ? null
        : TreeProcess.fromJson(json['tp'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TreeProcessOverviewToJson(
        TreeProcessOverview instance) =>
    <String, dynamic>{
      'tp': instance.tp,
    };
