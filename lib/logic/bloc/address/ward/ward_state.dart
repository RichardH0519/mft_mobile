import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/address/ward_list.dart';

abstract class WardState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WardInitial extends WardState {}

class WardLoaded extends WardState {
  final WardList wardList;

  WardLoaded({@required this.wardList});

  @override
  // TODO: implement props
  List<Object> get props => [
        wardList,
      ];
}

class WardLoading extends WardState {}
