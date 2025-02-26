import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/contract_detail/dates_info.dart';

class DatesInfoList {
  final List<DatesInfo> result;

  DatesInfoList({@required this.result});

  factory DatesInfoList.fromJson(List<dynamic> json) {
    List<DatesInfo> dateInfo = [];
    dateInfo = json.map((i) => DatesInfo.fromJson(i)).toList();

    return DatesInfoList(result: dateInfo);
  }
}
