import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/garden/garden_list.dart';

abstract class GardenState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GardenInitial extends GardenState {}

class GardenLoaded extends GardenState {
  final GardenList gardenList;

  GardenLoaded({@required this.gardenList});

  @override
  // TODO: implement props
  List<Object> get props => [
        gardenList,
      ];
}

class GardenByInterestLoaded extends GardenState {
  final GardenList gardenList;

  GardenByInterestLoaded({@required this.gardenList});

  @override
  // TODO: implement props
  List<Object> get props => [
        gardenList,
      ];
}

class GardenByPlantTypeLoaded extends GardenState {
  final GardenList gardenList;

  GardenByPlantTypeLoaded({@required this.gardenList});

  @override
  // TODO: implement props
  List<Object> get props => [
        gardenList,
      ];
}

class GardenEmpty extends GardenState {}

class GardenLoading extends GardenState {}
