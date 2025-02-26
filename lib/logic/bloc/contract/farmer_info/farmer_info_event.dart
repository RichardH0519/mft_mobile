import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FarmerInfoEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetFarmerInfo extends FarmerInfoEvent {
  final int treeID;

  GetFarmerInfo({@required this.treeID});

  @override
  // TODO: implement props
  List<Object> get props => [
        treeID,
      ];
}