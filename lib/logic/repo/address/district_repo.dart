import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/address/district_api.dart';
import 'package:mft_customer_side/model/address/district_list.dart';

class DistrictRepo {
  final DistrictAPI apiClient;

  DistrictRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<DistrictList> getDistricts(int cityID) {
    return apiClient.getDistricts(
      cityID: cityID,
    );
  }
}
