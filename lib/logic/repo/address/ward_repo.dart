import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/address/ward_api.dart';
import 'package:mft_customer_side/model/address/ward_list.dart';

class WardRepo {
  final WardAPI apiClient;

  WardRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<WardList> getWards(int districtID) {
    return apiClient.getWardsByDistrict(
      districtID: districtID,
    );
  }
}
