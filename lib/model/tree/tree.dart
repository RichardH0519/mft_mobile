import 'package:json_annotation/json_annotation.dart';

part 'tree.g.dart';

@JsonSerializable()
class Tree {
  final int id;
  final String treeCode;
  final String standard;
  final int price;
  final String image;
  final DateTime addDate;
  final String description;
  final int crops;
  final double yield;
  final int shipFee;

  Tree({
    this.id,
    this.treeCode,
    this.standard,
    this.price,
    this.image,
    this.addDate,
    this.description,
    this.crops,
    this.yield,
    this.shipFee,
  });

  factory Tree.fromJson(Map<String, dynamic> json) => _$TreeFromJson(json);

  Map<String, dynamic> toJson() => _$TreeToJson(this);
}
