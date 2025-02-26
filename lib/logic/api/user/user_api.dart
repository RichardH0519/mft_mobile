import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/tree_type/tree_type_by_username_list.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/model/user/user_list.dart';
import 'package:mft_customer_side/model/user/user_login.dart';
import 'package:mft_customer_side/model/user/user_register.dart';

class UserAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/Account';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  UserAPI({@required this.httpClient}) : assert(httpClient != null);

  //get user info
  Future<UserList> getUserInfo(User user) async {
    final url = '$baseUrl/GetAccountForContractByUsername/${user.username}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get user info");
    }

    final userJson = jsonDecode(utf8.decode(response.bodyBytes));

    return UserList.fromJson(userJson);
  }

  //get tree type by username
  Future<TreeTypeByUsernameList> getTreeTypeByUsername(User user) async {
    final url = '$baseUrl/GetTreeTypeIdByUsername/${user.username}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get tree type by username");
    }

    final treeTypesJson = jsonDecode(utf8.decode(response.bodyBytes));

    return TreeTypeByUsernameList.fromJson(treeTypesJson);
  }

  //user login
  Future<UserList> checkLogin(UserLogin user) async {
    const url = '$baseUrl/loginApp';
    final response = await httpClient.post(url,
        headers: headers, body: json.encode(user.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to login");
    }

    final userJson = jsonDecode(utf8.decode(response.bodyBytes));

    return UserList.fromJson(userJson);
  }

  //user register
  Future<bool> register(UserRegister user) async {
    const url = '$baseUrl/registerCustomer';
    var status = false;

    final response = await httpClient.post(url,
        headers: headers, body: json.encode(user.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to register");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //user edit
  Future<bool> edit(UserRegister user) async {
    const url = '$baseUrl/updateAccountApp';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(user.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to edit");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //uploaduser avater (upload to db)
  Future<bool> uploadAvatar(User user) async {
    const url = '$baseUrl/updateAccountAvatar';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(user.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to upload");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //remove account avatar
  Future<bool> removeAvatar(User user) async {
    const url = '$baseUrl/updateAccountAvatar';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(user.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to remove");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //upload user avatar (upload to firebase then upload at database)
  Future<bool> uploadUserAvatar(String username, File image) async {
    var status = false;

    String fileName = basename(image.path);
    final storageRef =
        FirebaseStorage.instance.ref().child("folderApp/$fileName");
    TaskSnapshot snapshot = await storageRef.putFile(image);
    var value = await snapshot.ref.getDownloadURL();

    status = await uploadAvatar(
      User(
        username: username,
        avatar: value,
      ),
    );

    return status;
    /*storageRef.putFile(image).then(
      (TaskSnapshot snapshot) {
        snapshot.ref.getDownloadURL().then(
          (value) {
            uploadAvatar(
              User(
                username: username,
                avatar: value,
              ),
            );
          },
        );
      },
    );*/
  }
}
