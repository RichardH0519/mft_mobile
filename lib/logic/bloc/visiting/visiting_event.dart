import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class VisitingEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BookAVisit extends VisitingEvent {
  final String visitDate;
  final String customerUsername;
  final int gardenID;

  BookAVisit({
    @required this.visitDate,
    @required this.customerUsername,
    @required this.gardenID,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        visitDate,
        customerUsername,
        gardenID,
      ];
}

class GetVisitSchedule extends VisitingEvent {
  final String username;

  GetVisitSchedule({@required this.username});
  @override
  // TODO: implement props
  List<Object> get props => [username];
}
