import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UserInterestEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InterestDeleteBtnPressed extends UserInterestEvent {
  final int id;

  InterestDeleteBtnPressed({@required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
      ];
}

class InterestUpdateBtnPressed extends UserInterestEvent {
  final int id;
  final String username;
  final int treeTypeID;

  InterestUpdateBtnPressed({
    @required this.id,
    @required this.username,
    @required this.treeTypeID,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        username,
        treeTypeID,
      ];
}
