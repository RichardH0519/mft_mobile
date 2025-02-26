import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree_type/tree_type_list.dart';

abstract class TreeTypeState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TreeTypeInitial extends TreeTypeState {}

class TreeTypeLoaded extends TreeTypeState {
  final TreeTypeList treeTypeList;

  TreeTypeLoaded({@required this.treeTypeList});

  @override
  // TODO: implement props
  List<Object> get props => [
        treeTypeList,
      ];
}

class TreeTypeLoading extends TreeTypeState {}
