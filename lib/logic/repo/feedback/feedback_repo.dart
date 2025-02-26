import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/feedback/feedback_api.dart';
import 'package:mft_customer_side/model/feedback/feedback.dart';

class FeedbackRepo {
  final FeedbackAPI apiClient;

  FeedbackRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<bool> sendFeedback(
      String customerUsername, String farmerUsername, String feedback) {
    return apiClient.sendFeedback(
      CustomerFeedback(
        customerUsername: customerUsername,
        farmerUsername: farmerUsername,
        feedback: feedback,
      ),
    );
  }
}
