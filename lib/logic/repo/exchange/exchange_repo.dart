import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/exchange/exchange_api.dart';
import 'package:mft_customer_side/model/exchange/accept_exchange.dart';
import 'package:mft_customer_side/model/exchange/cancel_exchange.dart';
import 'package:mft_customer_side/model/exchange/exchange_info_list.dart';
import 'package:mft_customer_side/model/exchange/exchange_request.dart';
import 'package:mft_customer_side/model/exchange/exchange_request_list.dart';
import 'package:mft_customer_side/model/exchange/exchange_response.dart';
import 'package:mft_customer_side/model/exchange/exchange_response_list.dart';
import 'package:mft_customer_side/model/exchange/request_add.dart';
import 'package:mft_customer_side/model/exchange/request_edit.dart';
import 'package:mft_customer_side/model/exchange/response_add.dart';
import 'package:mft_customer_side/model/exchange/response_edit.dart';
import 'package:mft_customer_side/model/tree/tree_info_list.dart';
import 'package:mft_customer_side/model/user/user.dart';

class ExchangeRepo {
  final ExchangeAPI apiClient;

  ExchangeRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<bool> createRequest(
    int plantTypeID,
    int weight,
    int contractID,
    String username,
  ) {
    return apiClient.createRequest(
      RequestAdd(
        plantTypeID: plantTypeID,
        weight: weight,
        contractID: contractID,
        username: username,
      ),
    );
  }

  Future<bool> createResponse(
    int exchangeRequestID,
    int weight,
    int contractID,
    String username,
    int requestWeight,
  ) {
    return apiClient.createResponse(
      ResponseAdd(
        exchangeRequestID: exchangeRequestID,
        weight: weight,
        contractID: contractID,
        username: username,
        requestWeight: requestWeight,
      ),
    );
  }

  Future<bool> editRequest(int requestID, int weight) {
    return apiClient.editWeight(
      RequestEdit(
        requestID: requestID,
        weight: weight,
      ),
    );
  }

  Future<bool> editResponse(
      int responseID, int weight, int contractID, int requestWeight) {
    return apiClient.editResponseWeight(
      ResponseEdit(
        responseID: responseID,
        weight: weight,
        contractID: contractID,
        requestWeight: requestWeight,
      ),
    );
  }

  Future<bool> cancelRequest(int requestID) {
    return apiClient.cancelRequest(
      ExchangeRequest(
        id: requestID,
      ),
    );
  }

  Future<bool> cancelResponse(int responseID) {
    return apiClient.cancelResponse(
      ExchangeResponse(
        id: responseID,
      ),
    );
  }

  Future<ExchangeRequestList> getAllRequestByUsername(String username) {
    return apiClient.getAllRequestByUsername(
      User(
        username: username,
      ),
    );
  }

  Future<ExchangeResponseList> getAllResponseByUsername(String username) {
    return apiClient.getAllResponseByUsername(
      User(
        username: username,
      ),
    );
  }

  Future<ExchangeResponseList> getAllResponseByRequestID(int requestID) {
    return apiClient.getAllResponseByRequestID(
      ExchangeRequest(
        id: requestID,
      ),
    );
  }

  Future<bool> rejectResponse(int responseID) {
    return apiClient.rejectResponse(
      ExchangeResponse(
        id: responseID,
      ),
    );
  }

  Future<ExchangeRequestList> getAllActiveRequest(String username) {
    return apiClient.getAllActiveRequest(
      username,
    );
  }

  Future<ExchangeRequestList> getAllActiveRequestByInterest(String username) {
    return apiClient.getAllActiveRequestByInterest(
      username,
    );
  }

  Future<bool> acceptExchange(int requestID, int responseID) {
    return apiClient.acceptExchange(
      AcceptExchange(
        requestID: requestID,
        responseID: responseID,
      ),
    );
  }

  Future<bool> fromRequestCancel(int managementID) {
    return apiClient.fromRequestCancel(
      CancelExchange(
        managementID: managementID,
      ),
    );
  }

  Future<bool> fromResponseCancel(int managementID) {
    return apiClient.fromResponseCancel(
      CancelExchange(
        managementID: managementID,
      ),
    );
  }

  Future<bool> cancelExchange(int requestID, int responseID, int managementID) {
    return apiClient.cancelExchange(
      CancelExchange(
        requestID: requestID,
        responseID: responseID,
        managementID: managementID,
      ),
    );
  }

  Future<ExchangeRequestList> getRequestWeight(int responseID) {
    return apiClient.getRequestWeight(
      ExchangeResponse(id: responseID),
    );
  }

  Future<ExchangeInfoList> getExchangeInfoByRequestID(int requestID) {
    return apiClient.getExchangeInfoByRequestID(requestID);
  }

  Future<ExchangeInfoList> getExchangeInfoByResponseID(int responseID) {
    return apiClient.getExchangeInfoByResponseID(responseID);
  }

  Future<TreeInfoList> getTreeInfoByRequest(int requestID) {
    return apiClient.getTreeDetailByRequest(requestID);
  }

  Future<ExchangeRequestList> getRequestByPlantType(
      String username, String plantTypeName) {
    return apiClient.getRequestByPlantType(username, plantTypeName);
  }
}
