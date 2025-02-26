import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/exchange/exchange_info.dart';

class ExchangeInfoList {
  final List<ExchangeInfo> result;

  ExchangeInfoList({@required this.result});

  factory ExchangeInfoList.fromJson(List<dynamic> json) {
    List<ExchangeInfo> infos = [];
    infos = json.map((i) => ExchangeInfo.fromJson(i)).toList();

    return ExchangeInfoList(result: infos);
  }
}
