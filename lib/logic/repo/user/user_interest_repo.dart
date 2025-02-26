import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/user/user_interest_api.dart';
import 'package:mft_customer_side/model/user/user_interest.dart';
import 'package:mft_customer_side/model/user/user_interest_delete.dart';

class UserInterestRepo {
  final UserInterestAPI apiClient;

  UserInterestRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<bool> deleteInterest(int id) {
    return apiClient.deleteByID(
      UserInterestDelete(
        id: id,
      ),
    );
  }

  Future<bool> updateInterest(
    int id,
    String username,
    int treeTypeID,
  ) {
    return apiClient.updateInterest(
      UserInterest(
        id: id,
        username: username,
        treeTypeID: treeTypeID,
      ),
    );
  }
}
