import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract/contract.dart';
import 'package:mft_customer_side/model/contract/contract_cancel_info.dart';
import 'package:mft_customer_side/model/contract/contract_overview_list.dart';
import 'package:mft_customer_side/model/tree/tree_contract_info.dart';
import 'package:mft_customer_side/model/user/user.dart';

abstract class ContractState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ContractInitial extends ContractState {}

class ContractLoading extends ContractState {}

class ContractAddedSuccess extends ContractState {}

class ContractAddedFail extends ContractState {}

class ContractAcceptSuccess extends ContractState {}

class ContractAcceptFail extends ContractState {}

class ContractCancelSuccess extends ContractState {}

class ContractCancelFail extends ContractState {}

class ContractDeleteSuccess extends ContractState {}

class ContractDeleteFail extends ContractState {}

class ContractSendCancelSuccess extends ContractState {}

class ContractSendCancelFail extends ContractState {}

class ContractOverviewsLoaded extends ContractState {
  final ContractOverviewList contractOverviewList;

  ContractOverviewsLoaded({@required this.contractOverviewList});

  @override
  // TODO: implement props
  List<Object> get props => [contractOverviewList];
}

class ContractOverviewsEmpty extends ContractState {}

class ContractLoaded extends ContractState {
  final Contract contract;

  ContractLoaded({@required this.contract});

  @override
  // TODO: implement props
  List<Object> get props => [contract];
}

class CancelInfoLoaded extends ContractState {
  final ContractCancelInfo cancelInfo;

  CancelInfoLoaded({@required this.cancelInfo});
  @override
  // TODO: implement props
  List<Object> get props => [cancelInfo];
}
