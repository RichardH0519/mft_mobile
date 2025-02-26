import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/visiting/schedule_list.dart';
import 'package:mft_customer_side/model/visiting/visit_garden.dart';

class VisitingAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/VisitingSchedule';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  VisitingAPI({@required this.httpClient}) : assert(httpClient != null);

  //book a visit
  Future<bool> bookAVisit(VisitGarden visit) async {
    final url = '$baseUrl/AddVisitingSchedule';
    var status = false;

    final response = await httpClient.post(url,
        headers: headers, body: json.encode(visit.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to book");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }

  //get all user schedule
  Future<ScheduleList> getSchedule(String username) async {
    final url = '$baseUrl/GetAcceptVisitScheduleByUsername/$username';
    final response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to get schedule");
    }

    final json = jsonDecode(utf8.decode(response.bodyBytes));

    return ScheduleList.fromJson(json);
  }
}
