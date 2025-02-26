import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/plant_type/plant_type_list.dart';

abstract class PlantTypeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PlantTypeInitial extends PlantTypeState {}

class PlantTypeLoaded extends PlantTypeState {
  final PlantTypeList plantTypeList;

  PlantTypeLoaded({@required this.plantTypeList});

  @override
  // TODO: implement props
  List<Object> get props => [
        plantTypeList,
      ];
}

class PlantTypeLoading extends PlantTypeState {}
