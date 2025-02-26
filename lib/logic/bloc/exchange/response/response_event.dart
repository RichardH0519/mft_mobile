import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ResponseEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateResponse extends ResponseEvent {
  final int exchangeRequestID;
  final int weight;
  final int contractID;
  final String username;
  final int requestWeight;

  CreateResponse({
    @required this.exchangeRequestID,
    @required this.weight,
    @required this.contractID,
    @required this.username,
    @required this.requestWeight,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        exchangeRequestID,
        weight,
        contractID,
        username,
        requestWeight,
      ];
}

class EditResponse extends ResponseEvent {
  final int responseID;
  final int weight;
  final int contractID;
  final int requestWeight;

  EditResponse(
      {@required this.responseID,
      @required this.weight,
      @required this.contractID,
      @required this.requestWeight});

  @override
  // TODO: implement props
  List<Object> get props => [
        responseID,
        weight,
        requestWeight,
      ];
}

class CancelResponse extends ResponseEvent {
  final int responseID;

  CancelResponse({@required this.responseID});

  @override
  // TODO: implement props
  List<Object> get props => [responseID];
}

class GetRequestWeight extends ResponseEvent {
  final int responseID;

  GetRequestWeight({@required this.responseID});

  @override
  // TODO: implement props
  List<Object> get props => [responseID];
}
