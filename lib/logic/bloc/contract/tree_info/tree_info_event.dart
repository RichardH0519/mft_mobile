import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TreeInfoEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetTreeInfo extends TreeInfoEvent {
  final int treeID;

  GetTreeInfo({@required this.treeID});

  @override
  // TODO: implement props
  List<Object> get props => [
        treeID,
      ];
}