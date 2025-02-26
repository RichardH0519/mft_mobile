import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RequestEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateRequest extends RequestEvent {
  final int plantTypeID;
  final int weight;
  final int contractID;
  final String username;

  CreateRequest({
    @required this.plantTypeID,
    @required this.weight,
    @required this.contractID,
    @required this.username,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        plantTypeID,
        weight,
        contractID,
        username,
      ];
}

class EditRequest extends RequestEvent {
  final int requestID;
  final int weight;

  EditRequest({@required this.requestID, @required this.weight});

  @override
  // TODO: implement props
  List<Object> get props => [
        requestID,
        weight,
      ];
}

class RejectResponse extends RequestEvent {
  final int responseID;

  RejectResponse({@required this.responseID});

  @override
  // TODO: implement props
  List<Object> get props => [responseID];
}

class CancelRequest extends RequestEvent {
  final int requestID;

  CancelRequest({@required this.requestID});

  @override
  // TODO: implement props
  List<Object> get props => [requestID];
}

class GetAllActiveRequest extends RequestEvent {
  final String username;

  GetAllActiveRequest({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}

class GetAllActiveRequestByInterest extends RequestEvent {
  final String username;

  GetAllActiveRequestByInterest({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}

class GetAllResponse extends RequestEvent {
  final int requestID;

  GetAllResponse({@required this.requestID});

  @override
  // TODO: implement props
  List<Object> get props => [requestID];
}

class AcceptExchange extends RequestEvent {
  final int requestID;
  final int responseID;

  AcceptExchange({@required this.requestID, @required this.responseID});

  @override
  // TODO: implement props
  List<Object> get props => [
        requestID,
        responseID,
      ];
}

class GetTreeInfoByRequest extends RequestEvent {
  final int requestID;

  GetTreeInfoByRequest({@required this.requestID});

  @override
  // TODO: implement props
  List<Object> get props => [requestID];
}

class GetRequestByPlantType extends RequestEvent {
  final String username;
  final String plantTypeName;

  GetRequestByPlantType(
      {@required this.username, @required this.plantTypeName});

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
        plantTypeName,
      ];
}
