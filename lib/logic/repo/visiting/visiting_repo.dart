import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/visiting/visiting_api.dart';
import 'package:mft_customer_side/model/visiting/schedule_list.dart';
import 'package:mft_customer_side/model/visiting/visit_garden.dart';

class VisitingRepo {
  final VisitingAPI apiClient;

  VisitingRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<bool> bookAVisit(
    String visitDate,
    String customerUsername,
    int gardenID,
  ) {
    return apiClient.bookAVisit(
      VisitGarden(
        visitDate: visitDate,
        customerUsername: customerUsername,
        gardenID: gardenID,
      ),
    );
  }

  Future<ScheduleList> getSchedule(String username) {
    return apiClient.getSchedule(username);
  }
}
