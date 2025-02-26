import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_register.g.dart';

@JsonSerializable()
class UserRegister {
  final String username;
  final String password;
  final String fullname;
  final int gender;
  final String dateOfBirth;
  final String address;
  final int city;
  final int district;
  final int ward;
  final String phone;
  final String email;
  final String avatar;
  final int interestTree1;
  final int interestTree2;
  final int interestTree3;

  UserRegister({
    @required this.username,
    @required this.password,
    @required this.fullname,
    @required this.gender,
    @required this.dateOfBirth,
    @required this.address,
    @required this.city,
    @required this.district,
    @required this.ward,
    @required this.phone,
    this.email,
    this.avatar,
    this.interestTree1,
    this.interestTree2,
    this.interestTree3,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterToJson(this);
}
