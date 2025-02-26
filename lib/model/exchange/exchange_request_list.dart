import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/exchange/exchange_request.dart';

class ExchangeRequestList {
  final List<ExchangeRequest> result;

  ExchangeRequestList({@required this.result});

  factory ExchangeRequestList.fromJson(List<dynamic> json) {
    List<ExchangeRequest> requests = [];
    requests = json.map((i) => ExchangeRequest.fromJson(i)).toList();

    return ExchangeRequestList(result: requests);
  }
}
