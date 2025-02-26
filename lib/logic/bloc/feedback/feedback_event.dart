import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FeedbackEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SendFeedback extends FeedbackEvent {
  final String customerUsername;
  final String farmerUsername;
  final String feedback;

  SendFeedback({
    @required this.customerUsername,
    @required this.farmerUsername,
    @required this.feedback,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        customerUsername,
        farmerUsername,
        feedback,
      ];
}
