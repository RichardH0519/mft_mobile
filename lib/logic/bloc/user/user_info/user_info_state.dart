import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/user/user.dart';

abstract class UserInfoState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final User user;

  UserInfoLoaded({@required this.user});

  @override
  // TODO: implement props
  List<Object> get props => [
        user,
      ];
}

class UserInfoLoading extends UserInfoState {}
