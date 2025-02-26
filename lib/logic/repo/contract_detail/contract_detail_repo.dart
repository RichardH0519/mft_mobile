import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/contract_detail/contract_detail_api.dart';
import 'package:mft_customer_side/model/contract_detail/contract_detail_list.dart';
import 'package:mft_customer_side/model/contract_detail/dates_info_list.dart';
import 'package:mft_customer_side/model/contract_detail/delivery_date.dart';

class ContractDetailRepo {
  final ContractDetailAPI apiClient;

  ContractDetailRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<bool> sendDeliveryDate(int contractID, String deliveryDate) {
    return apiClient.sendDeliveryDate(
      DeliveryDate(
        contractID: contractID,
        deliveryDate: deliveryDate,
      ),
    );
  }

  Future<DatesInfoList> getDatesInfo(int contractID) {
    return apiClient.getDatesInfo(contractID);
  }

  Future<ContractDetailList> getContractDetails(int contractID) {
    return apiClient.getContractDetails(contractID);
  }
}
