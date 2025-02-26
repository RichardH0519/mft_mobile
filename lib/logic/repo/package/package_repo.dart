import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/package/pakage_api.dart';
import 'package:mft_customer_side/model/package/delivery_list.dart';
import 'package:mft_customer_side/model/package/yield_list.dart';

class PackageRepo {
  final PackageAPI apiClient;

  PackageRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<YieldList> getYield(String username, int contractID) {
    return apiClient.getRemainingYield(
      username: username,
      contractID: contractID,
    );
  }

  Future<DeliveryList> getDeliverySchedule(String username) {
    return apiClient.getDeliverySchedule(username);
  }
}
