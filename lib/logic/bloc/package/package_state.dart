import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/package/delivery_list.dart';
import 'package:mft_customer_side/model/package/yield.dart';

abstract class PackageState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class YieldLoaded extends PackageState {
  final Yield yields;

  YieldLoaded({@required this.yields});

  @override
  // TODO: implement props
  List<Object> get props => [
        yields,
      ];
}

class DeliveryScheduleLoaded extends PackageState {
  final DeliveryList deliveryList;

  DeliveryScheduleLoaded({@required this.deliveryList});

  @override
  // TODO: implement props
  List<Object> get props => [deliveryList];
}

class DeliveryScheduleEmpty extends PackageState {}
