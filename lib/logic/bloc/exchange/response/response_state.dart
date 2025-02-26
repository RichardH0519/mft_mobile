import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/exchange/exchange_request.dart';
import 'package:mft_customer_side/model/exchange/exchange_response_list.dart';

abstract class ResponseState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ResponseInitial extends ResponseState {}

class ResponseLoading extends ResponseState {}

class ResponseCreateSuccess extends ResponseState {}

class ResponseCreateFail extends ResponseState {}

class ResponseEditSuccess extends ResponseState {}

class ResponseEditFail extends ResponseState {}

class ResponseCancelSuccess extends ResponseState {}

class ResponseCancelFail extends ResponseState {}

class ResponseListEmpty extends ResponseState {}

class RequestWeightLoaded extends ResponseState {
  final ExchangeRequest request;

  RequestWeightLoaded({@required this.request});

  @override
  // TODO: implement props
  List<Object> get props => [request];
}
