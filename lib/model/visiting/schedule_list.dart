import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/visiting/schedule.dart';

class ScheduleList {
  final List<Schedule> result;

  ScheduleList({@required this.result});

  factory ScheduleList.fromJson(List<dynamic> json) {
    List<Schedule> list = [];
    list = json.map((i) => Schedule.fromJson(i)).toList();

    return ScheduleList(result: list);
  }
}
