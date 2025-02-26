import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ContractRateEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetContractRate extends ContractRateEvent {
  final int requestID;

  GetContractRate({@required this.requestID});

  @override
  // TODO: implement props
  List<Object> get props => [requestID];
}
