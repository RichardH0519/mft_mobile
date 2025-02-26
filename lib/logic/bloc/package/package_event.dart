import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/package/package.dart';

abstract class PackageEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetYield extends PackageEvent {
  final String username;
  final int contractID;

  GetYield({@required this.username, @required this.contractID});

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
        contractID,
      ];
}

class GetDeliverySchedule extends PackageEvent {
  final String username;

  GetDeliverySchedule({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}
