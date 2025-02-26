import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/contract/contract.dart';
import 'package:mft_customer_side/model/contract/contract_accept.dart';
import 'package:mft_customer_side/model/contract/contract_add.dart';
import 'package:mft_customer_side/model/contract/contract_cancel.dart';
import 'package:mft_customer_side/model/contract/contract_cancel_info_list.dart';
import 'package:mft_customer_side/model/contract/contract_list.dart';
import 'package:mft_customer_side/model/contract/contract_overview_list.dart';
import 'package:mft_customer_side/model/contract/contract_rate_list.dart';
import 'package:mft_customer_side/model/exchange/exchange_request.dart';
import 'package:mft_customer_side/model/tree/tree.dart';
import 'package:mft_customer_side/model/tree/tree_contract_info_list.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/model/user/user_list.dart';

class ContractAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/Contract';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  ContractAPI({@required this.httpClient}) : assert(httpClient != null);

  //get farmer info
  Future<UserList> getFarmerInfo(Tree tree) async {
    final url = '$baseUrl/FarmerInfo/${tree.id}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get farmer info");
    }

    final farmerJson = jsonDecode(utf8.decode(response.bodyBytes));

    return UserList.fromJson(farmerJson);
  }

  //get tree info
  Future<TreeContractInfoList> getTreeInfo(Tree tree) async {
    final url = '$baseUrl/TreeInfo/${tree.id}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get tree info");
    }

    final treeJson = jsonDecode(utf8.decode(response.bodyBytes));

    return TreeContractInfoList.fromJson(treeJson);
  }

  //get contract rate
  Future<ContractRateList> getContractRate(ExchangeRequest request) async {
    final url = '$baseUrl/GetTotalYieldPriceFromRequest/${request.id}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get contract rate");
    }

    final treeJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ContractRateList.fromJson(treeJson);
  }

  //add new contract
  Future<bool> addContract(ContractAdd contract) async {
    final url = '$baseUrl/addContract';
    var status = false;

    final response = await httpClient.post(url,
        headers: headers, body: json.encode(contract.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to add contract");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //get contract overviews
  Future<ContractOverviewList> getContractOverviews(User user) async {
    final url = '$baseUrl/ContractedTree/${user.username}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get contract overviews");
    }

    final contractJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ContractOverviewList.fromJson(contractJson);
  }

  //get contract by tree id
  Future<ContractList> getContractByTreeID(Tree tree) async {
    final url = '$baseUrl/GetContractByTreeId/${tree.id}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get contract by id");
    }

    final contractJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ContractList.fromJson(contractJson);
  }

  //get cancel info from contract
  Future<ContractCancelInfoList> getCancelInfo(int contractID) async {
    final url = '$baseUrl/GetContractById/$contractID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get cancel info");
    }

    final json = jsonDecode(utf8.decode(response.bodyBytes));

    return ContractCancelInfoList.fromJson(json);
  }

  //accept contract
  Future<bool> acceptContract(ContractAccept contract) async {
    final url = '$baseUrl/AcceptContract';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(contract.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to accept contract");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //cancel contract
  Future<bool> cancelContract(Contract contract) async {
    final url = '$baseUrl/AppConfirmCancelContract/${contract.contractID}';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(contract.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to cancel contract");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //delete contract
  Future<bool> deleteContractRequest(Contract contract) async {
    final url = '$baseUrl/CancelContract/${contract.contractID}';
    var status = false;

    final response = await httpClient.delete(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to delete contract request");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //send cancel request
  Future<bool> sendCancelRequest(ContractCancel contract) async {
    final url = '$baseUrl/AppCancelContract';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(contract.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to cancel contract");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }
}
