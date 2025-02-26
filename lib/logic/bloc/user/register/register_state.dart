import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFail extends RegisterState {}

class RegisterLoading extends RegisterState {}