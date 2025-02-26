import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UserInfoEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetUserInfo extends UserInfoEvent {
  final String username;

  GetUserInfo({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
      ];
}
