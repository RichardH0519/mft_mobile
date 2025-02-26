import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class EditEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EditBtnPressed extends EditEvent {
  final String username;
  final String password;
  final String fullname;
  final int gender;
  final String dateOfBirth;
  final String address;
  final int district;
  final int ward;
  final String phone;
  final String email;

  EditBtnPressed({
    @required this.username,
    @required this.password,
    @required this.fullname,
    @required this.gender,
    @required this.dateOfBirth,
    @required this.address,
    @required this.district,
    @required this.ward,
    @required this.phone,
    this.email,
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
        email,
      ];
}
