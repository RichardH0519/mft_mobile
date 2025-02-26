import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/contract/contract_api.dart';
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

class ContractRepo {
  final ContractAPI apiClient;

  ContractRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<UserList> getFarmerInfo(int id) {
    return apiClient.getFarmerInfo(
      Tree(
        id: id,
      ),
    );
  }

  Future<TreeContractInfoList> getTreeInfo(int id) {
    return apiClient.getTreeInfo(
      Tree(
        id: id,
      ),
    );
  }

  Future<ContractRateList> getContractRate(int requestID) {
    return apiClient.getContractRate(
      ExchangeRequest(
        id: requestID,
      ),
    );
  }

  Future<bool> addNewContract(
    int treeID,
    String customerUsername,
    String farmerUsername,
    int numOfYear,
    int totalPrice,
    double totalYield,
    int totalCrop,
    int shipFee,
  ) {
    return apiClient.addContract(
      ContractAdd(
        treeID: treeID,
        customerUsername: customerUsername,
        farmerUsername: farmerUsername,
        numOfYear: numOfYear,
        totalPrice: totalPrice,
        totalYield: totalYield,
        totalCrop: totalCrop,
        shipFee: shipFee,
      ),
    );
  }

  Future<ContractOverviewList> getContractOverviews(String username) {
    return apiClient.getContractOverviews(
      User(
        username: username,
      ),
    );
  }

  Future<ContractList> getContractByTreeID(int treeID) {
    return apiClient.getContractByTreeID(Tree(
      id: treeID,
    ));
  }

  Future<ContractCancelInfoList> getCancelInfo(int contractID) {
    return apiClient.getCancelInfo(contractID);
  }

  Future<bool> acceptContract(int treeID, int contractID) {
    return apiClient.acceptContract(
      ContractAccept(
        treeID: treeID,
        contractID: contractID,
      ),
    );
  }

  Future<bool> cancelContract(int contractID) {
    return apiClient.cancelContract(
      Contract(
        contractID: contractID,
      ),
    );
  }

  Future<bool> deleteContractRequest(int contractID) {
    return apiClient.deleteContractRequest(
      Contract(
        contractID: contractID,
      ),
    );
  }

  Future<bool> sendCancelContract(
    int contractID,
    String cancelParty,
    String cancelReason,
    int refund,
  ) {
    return apiClient.sendCancelRequest(
      ContractCancel(
        contractID: contractID,
        cancelParty: cancelParty,
        cancelReason: cancelReason,
        refund: refund,
      ),
    );
  }
}
