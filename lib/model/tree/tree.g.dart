// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tree _$TreeFromJson(Map<String, dynamic> json) {
  return Tree(
    id: json['id'] as int,
    treeCode: json['treeCode'] as String,
    standard: json['standard'] as String,
    price: json['price'] as int,
    image: json['image'] as String,
    addDate: json['addDate'] == null
        ? null
        : DateTime.parse(json['addDate'] as String),
    description: json['description'] as String,
    crops: json['crops'] as int,
    yield: (json['yield'] as num)?.toDouble(),
    shipFee: json['shipFee'] as int,
  );
}

Map<String, dynamic> _$TreeToJson(Tree instance) => <String, dynamic>{
      'id': instance.id,
      'treeCode': instance.treeCode,
      'standard': instance.standard,
      'price': instance.price,
      'image': instance.image,
      'addDate': instance.addDate?.toIso8601String(),
      'description': instance.description,
      'crops': instance.crops,
      'yield': instance.yield,
      'shipFee': instance.shipFee,
    };
