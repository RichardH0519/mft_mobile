import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/block/blocked_info.dart';

class BlockedList {
  final List<BlockedInfo> result;

  BlockedList({@required this.result});

  factory BlockedList.fromJson(List<dynamic> json) {
    List<BlockedInfo> list = [];
    list = json.map((i) => BlockedInfo.fromJson(i)).toList();

    return BlockedList(result: list);
  }
}
