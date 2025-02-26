import 'package:equatable/equatable.dart';

abstract class UserInterestState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserInterestInitial extends UserInterestState {}

class UserInterestDeleteSuccess extends UserInterestState {}

class UserInterestDeleteFail extends UserInterestState {}

class UserInterestUpdateSuccess extends UserInterestState {}

class UserInterestUpdateFail extends UserInterestState {}

class UserInterestLoading extends UserInterestState {}
