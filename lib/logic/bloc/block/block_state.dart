import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/block/blocked_list.dart';

abstract class BlockState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BlockInitial extends BlockState {}

class BlockLoading extends BlockState {}

class BlockSuccess extends BlockState {}

class BlockFail extends BlockState {}

class UnblockSuccess extends BlockState {}

class UnblockFail extends BlockState {}

class BlockedListEmpty extends BlockState {}

class BlockedListLoaded extends BlockState {
  final BlockedList blockedList;

  BlockedListLoaded({@required this.blockedList});

  @override
  // TODO: implement props
  List<Object> get props => [blockedList];
}
