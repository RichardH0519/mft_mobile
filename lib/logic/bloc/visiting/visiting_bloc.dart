import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_event.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_state.dart';
import 'package:mft_customer_side/logic/repo/visiting/visiting_repo.dart';

class VisitingBloc extends Bloc<VisitingEvent, VisitingState> {
  final VisitingRepo repo;

  VisitingBloc({@required this.repo}) : super(VisitingInitial());

  @override
  Stream<VisitingState> mapEventToState(VisitingEvent event) async* {
    // TODO: implement mapEventToState
    if (event is BookAVisit) {
      yield VisitingLoading();

      try {
        final status = await repo.bookAVisit(
          event.visitDate,
          event.customerUsername,
          event.gardenID,
        );

        if (status == true) {
          yield BookVisitSuccess();
        } else {
          yield BookVisitFail();
        }
      } catch (_) {
        yield VisitingLoading();
      }
    }

    if (event is GetVisitSchedule) {
      yield VisitingLoading();

      try {
        final list = await repo.getSchedule(event.username);

        if (list.result.isNotEmpty) {
          yield VisitScheduleLoaded(scheduleList: list);
        } else {
          yield VisitScheduleEmpty();
        }
      } catch (_) {
        yield VisitingLoading();
      }
    }
  }
}
