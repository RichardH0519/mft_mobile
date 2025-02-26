import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WardEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetWards extends WardEvent {
  final int districtID;

  GetWards({@required this.districtID});

  @override
  // TODO: implement props
  List<Object> get props => [districtID];
}
