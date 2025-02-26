import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginBtnPressed extends LoginEvent {
  final String username;
  final String password;

  LoginBtnPressed({
    @required this.username,
    @required this.password,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
        password,
      ];
}
