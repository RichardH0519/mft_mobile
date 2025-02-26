import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/exchange/exchange_response.dart';

class ExchangeResponseList {
  final List<ExchangeResponse> result;

  ExchangeResponseList({@required this.result});

  factory ExchangeResponseList.fromJson(List<dynamic> json) {
    List<ExchangeResponse> responses = [];
    responses = json.map((i) => ExchangeResponse.fromJson(i)).toList();

    return ExchangeResponseList(result: responses);
  }
}
