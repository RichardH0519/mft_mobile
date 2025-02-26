import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ManagementEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetExchangeInfoByRequestID extends ManagementEvent {
  final int requestID;

  GetExchangeInfoByRequestID({@required this.requestID});

  @override
  // TODO: implement props
  List<Object> get props => [requestID];
}

class GetExchangeInfoByResponseID extends ManagementEvent {
  final int responseID;

  GetExchangeInfoByResponseID({@required this.responseID});

  @override
  // TODO: implement props
  List<Object> get props => [responseID];
}

class FromRequestCancel extends ManagementEvent {
  final int managementID;

  FromRequestCancel({@required this.managementID});

  @override
  // TODO: implement props
  List<Object> get props => [managementID];
}

class FromResponseCancel extends ManagementEvent {
  final int managementID;

  FromResponseCancel({@required this.managementID});

  @override
  // TODO: implement props
  List<Object> get props => [managementID];
}

class CancelExchange extends ManagementEvent {
  final int requestID;
  final int responseID;
  final int managementID;

  CancelExchange(
      {@required this.requestID,
      @required this.responseID,
      @required this.managementID});
}
