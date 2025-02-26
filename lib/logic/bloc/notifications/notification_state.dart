import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mft_customer_side/model/notifications/customer_notification.dart';

abstract class NotificationState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationEmpty extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<CustomerNotification> list;

  NotificationLoaded({@required this.list});

  @override
  // TODO: implement props
  List<Object> get props => [
        list,
      ];
}
