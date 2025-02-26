import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/exchange/exchange_request_list.dart';
import 'package:mft_customer_side/model/exchange/exchange_response_list.dart';
import 'package:mft_customer_side/model/tree/tree_info.dart';

abstract class RequestState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestCreateSuccess extends RequestState {}

class RequestCreateFail extends RequestState {}

class RequestEditSuccess extends RequestState {}

class RequestEditFail extends RequestState {}

class RequestCancelSuccess extends RequestState {}

class RequestCancelFail extends RequestState {}

class ResponseRejectSuccess extends RequestState {}

class ResponseRejectFail extends RequestState {}

class AcceptExchangeSuccess extends RequestState {}

class AcceptExchangeFail extends RequestState {}

class RequestListEmpty extends RequestState {}

class AllActiveRequestLoaded extends RequestState {
  final ExchangeRequestList requestList;

  AllActiveRequestLoaded({@required this.requestList});

  @override
  // TODO: implement props
  List<Object> get props => [requestList];
}

class AllActiveRequestByInterestLoaded extends RequestState {
  final ExchangeRequestList requestList;

  AllActiveRequestByInterestLoaded({@required this.requestList});

  @override
  // TODO: implement props
  List<Object> get props => [requestList];
}

class AllRequestByPlantType extends RequestState {
  final ExchangeRequestList requestList;

  AllRequestByPlantType({@required this.requestList});

  @override
  // TODO: implement props
  List<Object> get props => [requestList];
}

class AllResponseLoaded extends RequestState {
  final ExchangeResponseList responseList;

  AllResponseLoaded({@required this.responseList});
}

class TreeInfoByRequestLoaded extends RequestState {
  final TreeInfo treeInfo;

  TreeInfoByRequestLoaded({@required this.treeInfo});

  @override
  // TODO: implement props
  List<Object> get props => [treeInfo];
}
