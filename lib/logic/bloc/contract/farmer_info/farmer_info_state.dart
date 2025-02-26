import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/user/user.dart';

abstract class FarmerInfoState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FarmerInfoInitial extends FarmerInfoState {}

class FarmerInfoLoading extends FarmerInfoState {}

class FarmerInfoLoaded extends FarmerInfoState {
  final User user;

  FarmerInfoLoaded({@required this.user});

  @override
  // TODO: implement props
  List<Object> get props => [
        user,
      ];
}
