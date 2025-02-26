import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/tree_process/tree_process_overview_list.dart';

abstract class TreeProcessState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TreeProcessInitial extends TreeProcessState {}

class TreeProcessLoading extends TreeProcessState {}

class TreeProcessLoaded extends TreeProcessState {
  final TreeProcessOverviewList overviewList;

  TreeProcessLoaded({@required this.overviewList});

  @override
  // TODO: implement props
  List<Object> get props => [overviewList];
}

class TreeProcessEmpty extends TreeProcessState {}
