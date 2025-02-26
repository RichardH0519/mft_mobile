import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/user/user.dart';

class UserList {
  final List<User> result;

  UserList({@required this.result});

  factory UserList.fromJson(List<dynamic> json) {

    List<User> users = [];
    users = json.map((i) => User.fromJson(i)).toList();

    return UserList(result: users);
  }
}
