import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ContractDetailEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SendDeliveryDate extends ContractDetailEvent {
  final int contractID;
  final String deliveryDate;

  SendDeliveryDate({@required this.contractID, @required this.deliveryDate});

  @override
  // TODO: implement props
  List<Object> get props => [
        contractID,
        deliveryDate,
      ];
}

class GetDates extends ContractDetailEvent {
  final int contractID;

  GetDates({@required this.contractID});

  @override
  // TODO: implement props
  List<Object> get props => [contractID];
}

class GetContractDetails extends ContractDetailEvent {
  final int contractID;

  GetContractDetails({@required this.contractID});

  @override
  // TODO: implement props
  List<Object> get props => [contractID];
}
