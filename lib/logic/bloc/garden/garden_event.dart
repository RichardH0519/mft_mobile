import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GardenEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetAllGarden extends GardenEvent {}

class GetAllGardenByInterest extends GardenEvent {
  final String username;

  GetAllGardenByInterest({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}

class GetAllGardenByPlantType extends GardenEvent {
  final String plantTypeName;

  GetAllGardenByPlantType({@required this.plantTypeName});

  @override
  // TODO: implement props
  List<Object> get props => [plantTypeName];
}
