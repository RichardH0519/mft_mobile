import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

class ExchangeAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/Exchange';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  ExchangeAPI({@required this.httpClient}) : assert(httpClient != null);

  // create exchange request
  Future<bool> createRequest(RequestAdd request) async {
    const url = '$baseUrl/AddExchangeRequest';
    var status = false;

    final response = await httpClient.post(url,
        headers: headers, body: json.encode(request.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to add request");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //create exchange response
  Future<bool> createResponse(ResponseAdd responseToRequest) async {
    const url = '$baseUrl/AddExchangeResponse';
    var status = false;

    final response = await httpClient.post(url,
        headers: headers, body: json.encode(responseToRequest.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to add response");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //edit request weight
  Future<bool> editWeight(RequestEdit request) async {
    const url = '$baseUrl/UpdateWeightRequest';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(request.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to edit weight");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //edit response weight
  Future<bool> editResponseWeight(ResponseEdit responseToRequest) async {
    const url = '$baseUrl/UpdateWeightResponse';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(responseToRequest.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to edit weight");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //cancel request
  Future<bool> cancelRequest(ExchangeRequest request) async {
    final url = '$baseUrl/DisableRequest/${request.id}';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(request.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to cancel request");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //cancel response
  Future<bool> cancelResponse(ExchangeResponse responseToRequest) async {
    final url = '$baseUrl/DeleteResponse/${responseToRequest.id}';
    var status = false;

    final response = await httpClient.delete(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to cancel request");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //get all request by username
  Future<ExchangeRequestList> getAllRequestByUsername(User user) async {
    final url = '$baseUrl/GetExhangeRequest/${user.username}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all request");
    }

    final requestsJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeRequestList.fromJson(requestsJson);
  }

  //get all response by username
  Future<ExchangeResponseList> getAllResponseByUsername(User user) async {
    final url = '$baseUrl/GetPendingResponseFromUsername/${user.username}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all response");
    }

    final requestsJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeResponseList.fromJson(requestsJson);
  }

  //get all response by requestID
  Future<ExchangeResponseList> getAllResponseByRequestID(
      ExchangeRequest request) async {
    final url = '$baseUrl/GetResponseFromRequestID/${request.id}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all response");
    }

    final requestsJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeResponseList.fromJson(requestsJson);
  }

  //reject a response
  Future<bool> rejectResponse(ExchangeResponse responseToRequest) async {
    final url =
        '$baseUrl/RejectResponse/responseID?responseID=${responseToRequest.id}';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(responseToRequest.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to reject response");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //get all active request
  Future<ExchangeRequestList> getAllActiveRequest(String username) async {
    final url = '$baseUrl/GetAllActiveRequest/$username';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all request");
    }

    final requestsJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeRequestList.fromJson(requestsJson);
  }

  //get all active request by interest
  Future<ExchangeRequestList> getAllActiveRequestByInterest(
      String username) async {
    final url = '$baseUrl/GetActiveRequestByInterest/$username';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all request");
    }

    final requestsJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeRequestList.fromJson(requestsJson);
  }

  //accept exchange
  Future<bool> acceptExchange(AcceptExchange accept) async {
    final url = '$baseUrl/AcceptExchange';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(accept.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to accept response");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //from request cancel exchange
  Future<bool> fromRequestCancel(CancelExchange cancel) async {
    final url = '$baseUrl/FromRequestCancelManagement/${cancel.managementID}';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(cancel.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to cancel exchange");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //from response cancel exchange
  Future<bool> fromResponseCancel(CancelExchange cancel) async {
    final url = '$baseUrl/FromResponseCancelManagement/${cancel.managementID}';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(cancel.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to cancel exchange");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //cancel exchange
  Future<bool> cancelExchange(CancelExchange cancel) async {
    final url = '$baseUrl/ConfirmCancelExchange';
    var status = false;

    final response = await httpClient.put(url,
        headers: headers, body: json.encode(cancel.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to cancel exchange");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //get request's weight from responseID
  Future<ExchangeRequestList> getRequestWeight(
      ExchangeResponse responseToRequest) async {
    final url =
        '$baseUrl/GetRequestWeightFromResponseID/${responseToRequest.id}';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all request");
    }

    final requestsJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeRequestList.fromJson(requestsJson);
  }

  //get exchange info by requestID
  Future<ExchangeInfoList> getExchangeInfoByRequestID(int requestID) async {
    final url = '$baseUrl/GetExchangeManagementByRequestID/$requestID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all exchange info");
    }

    final exchangeInfoJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeInfoList.fromJson(exchangeInfoJson);
  }

  //get exchange info by responseID
  Future<ExchangeInfoList> getExchangeInfoByResponseID(int responseID) async {
    final url = '$baseUrl/GetExchangeManagementByResponseID/$responseID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all exchange info");
    }

    final exchangeInfoJson = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeInfoList.fromJson(exchangeInfoJson);
  }

  //get tree detail by request
  Future<TreeInfoList> getTreeDetailByRequest(int requestID) async {
    final url = '$baseUrl/GetTreeDetailByRequest/$requestID';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get tree detail");
    }

    final json = jsonDecode(utf8.decode(response.bodyBytes));

    return TreeInfoList.fromJson(json);
  }

  //get request by planttype
  Future<ExchangeRequestList> getRequestByPlantType(
      String username, String plantTypeName) async {
    final url = '$baseUrl/GetActiveRequestByPlantType/$username/$plantTypeName';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get all request");
    }

    final json = jsonDecode(utf8.decode(response.bodyBytes));

    return ExchangeRequestList.fromJson(json);
  }
}
