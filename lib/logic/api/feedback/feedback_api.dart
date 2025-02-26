import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/model/feedback/feedback.dart';

class FeedbackAPI {
  static const baseUrl = 'http://leminhnhan.cosplane.asia/api/Feedback';
  static const headers = {'Content-Type': 'application/json'};
  final http.Client httpClient;

  FeedbackAPI({@required this.httpClient}) : assert(httpClient != null);

  //send feedback
  Future<bool> sendFeedback(CustomerFeedback feedback) async {
    final url = '$baseUrl/AddFeedback';
    var status = false;

    final response = await httpClient.post(url,
        headers: headers, body: json.encode(feedback.toJson()));

    if (response.statusCode != 200) {
      throw Exception("Failed to send feedback");
    } else {
      if (response.body == "true") {
        status = true;
        return status;
      } else if (response.body == "false") {
        return status;
      }
    }
  }
}
