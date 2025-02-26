import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/model/tree_type/tree_type_by_username_list.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/model/user/user_list.dart';
import 'package:mft_customer_side/model/user/user_login.dart';
import 'package:mft_customer_side/model/user/user_register.dart';

class UserRepo {
  final UserAPI apiClient;

  UserRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<UserList> getUserInfo(String username) {
    return apiClient.getUserInfo(
      User(
        username: username,
      ),
    );
  }

  Future<TreeTypeByUsernameList> getTreeTypeByUsername(String username) {
    return apiClient.getTreeTypeByUsername(
      User(
        username: username,
      ),
    );
  }

  Future<UserList> login(String username, String password) {
    return apiClient.checkLogin(
      UserLogin(
        username: username,
        password: password,
      ),
    );
  }

  Future<bool> register(
    String username,
    String password,
    String fullname,
    int gender,
    String dateOfBirth,
    String address,
    int district,
    int ward,
    String phone,
    int interestTree1,
    int interestTree2,
    int interestTree3,
  ) {
    return apiClient.register(UserRegister(
      username: username,
      password: password,
      fullname: fullname,
      gender: gender,
      dateOfBirth: dateOfBirth,
      address: address,
      city: 1,
      district: district,
      ward: ward,
      phone: phone,
      email: null,
      avatar: null,
      interestTree1: interestTree1,
      interestTree2: interestTree2,
      interestTree3: interestTree3,
    ));
  }

  Future<bool> edit(
    String username,
    String password,
    String fullname,
    int gender,
    String dateOfBirth,
    String address,
    int district,
    int ward,
    String phone,
    String email,
  ) {
    return apiClient.edit(
      UserRegister(
        username: username,
        password: password,
        fullname: fullname,
        gender: gender,
        dateOfBirth: dateOfBirth,
        address: address,
        city: 1,
        district: district,
        ward: ward,
        phone: phone,
        email: email.isEmpty ? null : email,
      ),
    );
  }

  Future<bool> uploadUserAvatar(String username, File image) {
    return apiClient.uploadUserAvatar(username, image);
  }

  Future<bool> removeAvatar(String username) {
    return apiClient.removeAvatar(
      User(
        username: username,
        avatar: null,
      ),
    );
  }
}
