import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ContractEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddContract extends ContractEvent {
  final int treeID;
  final String customerUsername;
  final String farmerUsername;
  final int numOfYear;
  final int totalPrice;
  final double totalYield;
  final int totalCrop;
  final int shipFee;

  AddContract({
    @required this.treeID,
    @required this.customerUsername,
    @required this.farmerUsername,
    @required this.numOfYear,
    @required this.totalPrice,
    @required this.totalYield,
    @required this.totalCrop,
    @required this.shipFee,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        treeID,
        customerUsername,
        farmerUsername,
        numOfYear,
        totalPrice,
        totalYield,
        totalCrop,
      ];
}

class GetContractOverviews extends ContractEvent {
  final String username;

  GetContractOverviews({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}

class GetContractByTreeID extends ContractEvent {
  final int treeID;

  GetContractByTreeID({@required this.treeID});

  @override
  // TODO: implement props
  List<Object> get props => [treeID];
}

class GetContractCancelInfo extends ContractEvent {
  final int contractID;

  GetContractCancelInfo({@required this.contractID});

  @override
  // TODO: implement props
  List<Object> get props => [contractID];
}

class AcceptContract extends ContractEvent {
  final int treeID;
  final int contractID;

  AcceptContract({@required this.treeID, @required this.contractID});

  @override
  // TODO: implement props
  List<Object> get props => [
        treeID,
        contractID,
      ];
}

class CancelContract extends ContractEvent {
  final int contractID;

  CancelContract({@required this.contractID});

  @override
  // TODO: implement props
  List<Object> get props => [contractID];
}

class DeleteContractRequest extends ContractEvent {
  final int contractID;

  DeleteContractRequest({@required this.contractID});

  @override
  // TODO: implement props
  List<Object> get props => [contractID];
}

class SendCancelContract extends ContractEvent {
  final int contractID;
  final String cancelParty;
  final String cancelReason;
  final int refund;

  SendCancelContract({
    @required this.contractID,
    @required this.cancelParty,
    @required this.cancelReason,
    @required this.refund,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        contractID,
        cancelParty,
        cancelReason,
        refund,
      ];
}
