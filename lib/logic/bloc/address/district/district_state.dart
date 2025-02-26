import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/address/district_list.dart';

abstract class DistrictState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DistrictInitial extends DistrictState {}

class DistrictLoaded extends DistrictState {
  final DistrictList districtList;

  DistrictLoaded({@required this.districtList});

  @override
  // TODO: implement props
  List<Object> get props => [
        districtList,
      ];
}

class DistrictLoading extends DistrictState {}
