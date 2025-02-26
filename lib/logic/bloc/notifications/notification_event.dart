import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NotificationEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddRentNotification extends NotificationEvent {
  final String farmerUsername;
  final String userFullname;

  AddRentNotification(
      {@required this.farmerUsername, @required this.userFullname});

  @override
  // TODO: implement props
  List<Object> get props => [
        farmerUsername,
        userFullname,
      ];
}

class DeleteContractNotification extends NotificationEvent {
  final String farmerUsername;
  final int contractNumber;

  DeleteContractNotification(
      {@required this.farmerUsername, @required this.contractNumber});

  @override
  // TODO: implement props
  List<Object> get props => [
        farmerUsername,
        contractNumber,
      ];
}

class AcceptContractNotification extends NotificationEvent {
  final String farmerUsername;
  final int contractNumber;

  AcceptContractNotification(
      {@required this.farmerUsername, @required this.contractNumber});

  @override
  // TODO: implement props
  List<Object> get props => [
        farmerUsername,
        contractNumber,
      ];
}

class CancelContractNotification extends NotificationEvent {
  final String farmerUsername;
  final int contractNumber;

  CancelContractNotification(
      {@required this.farmerUsername, @required this.contractNumber});

  @override
  // TODO: implement props
  List<Object> get props => [
        farmerUsername,
        contractNumber,
      ];
}

class ConfirmCancelContractNotification extends NotificationEvent {
  final String farmerUsername;
  final int contractNumber;

  ConfirmCancelContractNotification(
      {@required this.farmerUsername, @required this.contractNumber});

  @override
  // TODO: implement props
  List<Object> get props => [
        farmerUsername,
        contractNumber,
      ];
}

class ChooseDeliveryDateNotification extends NotificationEvent {
  final String farmerUsername;
  final int contractNumber;

  ChooseDeliveryDateNotification(
      {@required this.farmerUsername, @required this.contractNumber});

  @override
  // TODO: implement props
  List<Object> get props => [
        farmerUsername,
        contractNumber,
      ];
}

class BookVisitNotification extends NotificationEvent {
  final String farmerUsername;
  final String customerFullname;
  final String gardenName;

  BookVisitNotification({
    @required this.farmerUsername,
    @required this.customerFullname,
    @required this.gardenName,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        farmerUsername,
        customerFullname,
        gardenName,
      ];
}

class GetCustomerNotification extends NotificationEvent {
  final String username;

  GetCustomerNotification({
    @required this.username,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
      ];
}

class UpdateCustomerNotification extends NotificationEvent {
  final String username;

  UpdateCustomerNotification({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
      ];
}

class SendResponseNotification extends NotificationEvent {
  final String requestusername;
  final String plantTypename;

  SendResponseNotification(
      {@required this.requestusername, @required this.plantTypename});

  @override
  // TODO: implement props
  List<Object> get props => [
        requestusername,
        plantTypename,
      ];
}

class AcceptResponseNotification extends NotificationEvent {
  final String responseUsername;
  final String plantTypename;

  AcceptResponseNotification(
      {@required this.responseUsername, @required this.plantTypename});

  @override
  // TODO: implement props
  List<Object> get props => [
        responseUsername,
        plantTypename,
      ];
}

class RejectResponseNotification extends NotificationEvent {
  final String responseUsername;
  final String plantTypename;

  RejectResponseNotification(
      {@required this.responseUsername, @required this.plantTypename});

  @override
  // TODO: implement props
  List<Object> get props => [
        responseUsername,
        plantTypename,
      ];
}

class ResponseCancelNotification extends NotificationEvent {
  final String requestUsername;
  final String plantTypename;

  ResponseCancelNotification(
      {@required this.requestUsername, @required this.plantTypename});

  @override
  // TODO: implement props
  List<Object> get props => [
        requestUsername,
        plantTypename,
      ];
}

class ResponseConfirmCancelNotification extends NotificationEvent {
  final String requestUsername;
  final String plantTypename;

  ResponseConfirmCancelNotification(
      {@required this.requestUsername, @required this.plantTypename});

  @override
  // TODO: implement props
  List<Object> get props => [
        requestUsername,
        plantTypename,
      ];
}

class RequestCancelNotification extends NotificationEvent {
  final String responseUsername;
  final String plantTypename;

  RequestCancelNotification(
      {@required this.responseUsername, @required this.plantTypename});

  @override
  // TODO: implement props
  List<Object> get props => [
        responseUsername,
        plantTypename,
      ];
}

class RequestConfirmCancelNotification extends NotificationEvent {
  final String responseUsername;
  final String plantTypename;

  RequestConfirmCancelNotification(
      {@required this.responseUsername, @required this.plantTypename});

  @override
  // TODO: implement props
  List<Object> get props => [
        responseUsername,
        plantTypename,
      ];
}
