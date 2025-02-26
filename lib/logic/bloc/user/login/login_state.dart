import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/user/user.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({@required this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class LoginFail extends LoginState {}

class LoginLoading extends LoginState {}
