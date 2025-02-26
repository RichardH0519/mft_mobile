import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mft_customer_side/model/visiting/schedule_list.dart';

abstract class VisitingState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class VisitingInitial extends VisitingState {}

class VisitingLoading extends VisitingState {}

class BookVisitSuccess extends VisitingState {}

class BookVisitFail extends VisitingState {}

class VisitScheduleEmpty extends VisitingState {}

class VisitScheduleLoaded extends VisitingState {
  final ScheduleList scheduleList;

  VisitScheduleLoaded({@required this.scheduleList});

  @override
  // TODO: implement props
  List<Object> get props => [scheduleList];
}
