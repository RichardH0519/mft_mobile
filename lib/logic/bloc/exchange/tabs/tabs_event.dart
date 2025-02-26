import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TabsEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetRequestByUsername extends TabsEvent {
  final String username;

  GetRequestByUsername({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}

class GetResponseByUsername extends TabsEvent {
  final String username;

  GetResponseByUsername({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}
