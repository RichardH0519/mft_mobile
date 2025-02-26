import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract_detail/contract_detail_list.dart';
import 'package:mft_customer_side/model/contract_detail/dates_info.dart';

abstract class ContractDetailState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ContractDetailInitial extends ContractDetailState {}

class ContractDetailLoading extends ContractDetailState {}

class SendContractDetailSuccess extends ContractDetailState {}

class SendContractDetailFail extends ContractDetailState {}

class DatesInfoEmpty extends ContractDetailState {}

class ContractDetailsEmpty extends ContractDetailState {}

class ContractDetailsLoaded extends ContractDetailState {
  final ContractDetailList contractDetailList;

  ContractDetailsLoaded({@required this.contractDetailList});

  @override
  // TODO: implement props
  List<Object> get props => [contractDetailList];
}

class DatesInfoLoaded extends ContractDetailState {
  final DatesInfo datesInfo;

  DatesInfoLoaded({@required this.datesInfo});

  @override
  // TODO: implement props
  List<Object> get props => [datesInfo];
}
