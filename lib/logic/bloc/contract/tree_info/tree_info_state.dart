import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree/tree_contract_info.dart';

abstract class TreeInfoState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TreeInfoInitial extends TreeInfoState {}

class TreeInfoLoading extends TreeInfoState {}

class TreeInfoLoaded extends TreeInfoState {
  final TreeContractInfo tree;

  TreeInfoLoaded({@required this.tree});

  @override
  // TODO: implement props
  List<Object> get props => [
        tree,
      ];
}
