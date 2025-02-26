import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree/tree_list.dart';

abstract class TreeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TreeInitial extends TreeState {}

class TreeLoaded extends TreeState {
  final TreeList treeList;

  TreeLoaded({@required this.treeList});

  @override
  // TODO: implement props
  List<Object> get props => [
        treeList,
      ];
}

class TreeEmpty extends TreeState {}

class TreeLoading extends TreeState {}
