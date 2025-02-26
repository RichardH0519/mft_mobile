import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree_type/tree_type_by_username_list.dart';

abstract class TreeTypeByUsernameState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TreeTypeByUsernameInitial extends TreeTypeByUsernameState {}

class TreeTypeByUsernameLoading extends TreeTypeByUsernameState {}

class TreeTypeByUsernameLoaded extends TreeTypeByUsernameState {
  final TreeTypeByUsernameList treeTypeByUsernameList;

  TreeTypeByUsernameLoaded({@required this.treeTypeByUsernameList});

  @override
  // TODO: implement props
  List<Object> get props => [
        treeTypeByUsernameList,
      ];
}

class TreeTypeByUsernameEmpty extends TreeTypeByUsernameState {}
