import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TreeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetAllTree extends TreeEvent {
  final int gardenID;

  GetAllTree({@required this.gardenID});

  @override
  // TODO: implement props
  List<Object> get props => [
        gardenID,
      ];
}
