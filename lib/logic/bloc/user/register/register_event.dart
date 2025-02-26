import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegisterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterBtnPressed extends RegisterEvent {
  final String username;
  final String password;
  final String fullname;
  final int gender;
  final String dateOfBirth;
  final String address;
  final int district;
  final int ward;
  final String phone;
  final int interestTree1;
  final int interestTree2;
  final int interestTree3;

  RegisterBtnPressed({
    @required this.username,
    @required this.password,
    @required this.fullname,
    @required this.gender,
    @required this.dateOfBirth,
    @required this.address,
    @required this.district,
    @required this.ward,
    @required this.phone,
    this.interestTree1,
    this.interestTree2,
    this.interestTree3,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
        password,
        fullname,
        gender,
        dateOfBirth,
        address,
        district,
        ward,
        phone,
        interestTree1,
        interestTree2,
        interestTree3,
      ];
}
