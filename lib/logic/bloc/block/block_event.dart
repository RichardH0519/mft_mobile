import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BlockEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BlockPressed extends BlockEvent {
  final String username;
  final String blocked;

  BlockPressed({@required this.username, @required this.blocked});

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
        blocked,
      ];
}

class Unblock extends BlockEvent {
  final int id;

  Unblock({@required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class GetBlockedList extends BlockEvent {
  final String username;

  GetBlockedList({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [username];
}
