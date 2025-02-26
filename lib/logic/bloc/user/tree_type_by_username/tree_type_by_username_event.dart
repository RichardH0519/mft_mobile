import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TreeTypeByUsernameEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetTreeTypeByUsername extends TreeTypeByUsernameEvent {
  final String username;

  GetTreeTypeByUsername({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
      ];
}
