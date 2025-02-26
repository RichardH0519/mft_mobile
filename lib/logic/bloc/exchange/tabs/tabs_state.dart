import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/exchange/exchange_request_list.dart';
import 'package:mft_customer_side/model/exchange/exchange_response_list.dart';

abstract class TabsState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TabsInitial extends TabsState {}

class TabsLoading extends TabsState {}

class ListEmpty extends TabsState {}

class RequestListLoaded extends TabsState {
  final ExchangeRequestList requestList;

  RequestListLoaded({@required this.requestList});

  @override
  // TODO: implement props
  List<Object> get props => [requestList];
}

class ResponseListLoaded extends TabsState {
  final ExchangeResponseList responseList;

  ResponseListLoaded({@required this.responseList});

  @override
  // TODO: implement props
  List<Object> get props => [responseList];
}
