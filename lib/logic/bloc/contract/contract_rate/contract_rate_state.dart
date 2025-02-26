import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract/contract_rate.dart';

abstract class ContractRateState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ContractRateInitial extends ContractRateState {}

class ContractRateLoading extends ContractRateState {}

class ContractRateLoaded extends ContractRateState {
  final ContractRate contractRate;

  ContractRateLoaded({@required this.contractRate});

  @override
  // TODO: implement props
  List<Object> get props => [contractRate];
}
