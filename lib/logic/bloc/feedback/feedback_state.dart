import 'package:equatable/equatable.dart';

abstract class FeedbackState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class SendFeedbackSuccess extends FeedbackState {}

class SendFeedbackFail extends FeedbackState {}