import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/package/yield.dart';

class YieldList {
  final List<Yield> result;

  YieldList({@required this.result});

  factory YieldList.fromJson(List<dynamic> json) {
    List<Yield> yields = [];
    yields = json.map((i) => Yield.fromJson(i)).toList();

    return YieldList(result: yields);
  }
}
