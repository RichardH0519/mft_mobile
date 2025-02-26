import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/feedback/feedback_event.dart';
import 'package:mft_customer_side/logic/bloc/feedback/feedback_state.dart';
import 'package:mft_customer_side/logic/repo/feedback/feedback_repo.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepo repo;

  FeedbackBloc({@required this.repo}) : super(FeedbackInitial());

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SendFeedback) {
      yield FeedbackLoading();

      try {
        final status = await repo.sendFeedback(
          event.customerUsername,
          event.farmerUsername,
          event.feedback,
        );

        if (status == true) {
          yield SendFeedbackSuccess();
        } else {
          yield SendFeedbackFail();
        }
      } catch (_) {
        yield SendFeedbackFail();
      }
    }
  }
}
