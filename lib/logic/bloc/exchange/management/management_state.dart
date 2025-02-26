import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/exchange/exchange_info.dart';
import 'package:mft_customer_side/model/exchange/exchange_info_list.dart';

abstract class ManagementState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ManagementInitial extends ManagementState {}

class ManagementLoading extends ManagementState {}

class FromRequestCancelSuccess extends ManagementState {}

class FromRequestCancelFail extends ManagementState {}

class FromResponseCancelSuccess extends ManagementState {}

class FromResponseCancelFail extends ManagementState {}

class CancelExchangeSuccess extends ManagementState {}

class CancelExchangeFail extends ManagementState {}

class ExchangeInfoByRequestIDLoaded extends ManagementState {
  final ExchangeInfoList exchangeInfoList;

  ExchangeInfoByRequestIDLoaded({@required this.exchangeInfoList});

  @override
  // TODO: implement props
  List<Object> get props => [exchangeInfoList];
}

class ExchangeInfoByRequestIDEmpty extends ManagementState {}

class ExchangeInfoByResponseIDLoaded extends ManagementState {
  final ExchangeInfo exchangeInfo;

  ExchangeInfoByResponseIDLoaded({@required this.exchangeInfo});

  @override
  // TODO: implement props
  List<Object> get props => [exchangeInfo];
}

class ExchangeInfoByResponseIDEmpty extends ManagementState {}
