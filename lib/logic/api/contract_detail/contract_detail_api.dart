import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/contract_detail/contract_detail_list.dart';
import 'package:mft_customer_side/model/contract_detail/dates_info_list.dart';
import 'package:mft_customer_side/model/contract_detail/delivery_date.dart';

class ContractDetailAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/ContractDetail';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  ContractDetailAPI({@required this.httpClient}) : assert(httpClient != null);

  //send delivery date
  Future<bool> sendDeliveryDate(DeliveryDate date) async {
    final url = '$baseUrl/UpdateDeliveryDate';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(date.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to send delivery date");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //get dates info
  Future<DatesInfoList> getDatesInfo(int contractID) async {
    final url = '$baseUrl/AppGetContractDetailDatesByContractID/$contractID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get date info");
    }

    final datesJson = jsonDecode(utf8.decode(response.bodyBytes));

    return DatesInfoList.fromJson(datesJson);
  }

  //get all contract detail by contract id
  Future<ContractDetailList> getContractDetails(int contractID) async {
    final url = '$baseUrl/AppGetContractDetailByContractID/$contractID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get contract detail");
    }

    final json = jsonDecode(utf8.decode(response.bodyBytes));

    return ContractDetailList.fromJson(json);
  }
}
