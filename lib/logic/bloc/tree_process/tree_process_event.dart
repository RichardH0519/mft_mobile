import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TreeProcessEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetTreeProcess extends TreeProcessEvent {
  final int contractID;

  GetTreeProcess({@required this.contractID});

  @override
  // TODO: implement props
  List<Object> get props => [contractID];
}
