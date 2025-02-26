import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/package/package_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_state.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_bloc.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_state.dart';
import 'package:mft_customer_side/model/package/delivery.dart';
import 'package:mft_customer_side/model/visiting/schedule.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends BaseState<CalendarScreen> {
  List<Schedule> schedules = [];
  List<Delivery> deliveries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: Padding(
        padding: const EdgeInsets.only(
          top: Dimens.size35,
        ),
        child: BlocBuilder<PackageBloc, PackageState>(
          builder: (context, state) {
            if (state is DeliveryScheduleLoaded) {
              deliveries = state.deliveryList.result;

              return BlocBuilder<VisitingBloc, VisitingState>(
                builder: (context, state) {
                  if (state is VisitScheduleLoaded) {
                    schedules = state.scheduleList.result;
                  }

                  return SfCalendar(
                    view: CalendarView.month,
                    backgroundColor: Theme.of(context).accentColor,
                    selectionDecoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          4,
                        ),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    todayHighlightColor: Colors.green,
                    showNavigationArrow: true,
                    monthViewSettings: MonthViewSettings(
                      showAgenda: true,
                      agendaItemHeight: Dimens.size80,
                    ),
                    dataSource: EventDataSource(_getDataSource(
                      schedules,
                      deliveries,
                    )),
                  );
                },
              );
            }

            return SfCalendar(
              view: CalendarView.month,
              backgroundColor: Theme.of(context).accentColor,
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    4,
                  ),
                ),
                shape: BoxShape.rectangle,
              ),
              todayHighlightColor: Colors.green,
              showNavigationArrow: true,
              monthViewSettings: MonthViewSettings(
                showAgenda: true,
                agendaItemHeight: Dimens.size80,
              ),
            );
          },
        ),
      ),
    );
  }

  List<Event> _getDataSource(
      List<Schedule> scheduleList, List<Delivery> deliveryList) {
    final List<Event> meetings = <Event>[];
    if (scheduleList.isNotEmpty) {
      for (var schedule in scheduleList) {
        DateTime startTime = DateTime(
          schedule.v.visitDate.year,
          schedule.v.visitDate.month,
          schedule.v.visitDate.day,
          schedule.v.visitDate.hour,
          schedule.v.visitDate.minute,
        );
        DateTime endTime = startTime.add(
          Duration(
            hours: 2,
          ),
        );
        meetings.add(
          Event(
              "Hẹn thăm ${schedule.gardenName} (dự kiến 2 tiếng)\nSDT liên lạc: ${schedule.phone}\n",
              startTime,
              endTime,
              Colors.blue,
              false),
        );
      }
    }

    if (deliveryList.isNotEmpty) {
      for (var delivery in deliveryList) {
        if (DateFormat("yyyy-MM-dd").format(delivery.deliveryDate) !=
            "0001-01-01") {
          DateTime startDelivery = DateTime(
            delivery.deliveryDate.year,
            delivery.deliveryDate.month,
            delivery.deliveryDate.day,
          );

          DateTime endDelivery = startDelivery;

          meetings.add(
            Event(
                'Nhận ${delivery.pd.yield} kg ${delivery.plantTypeName}',
                startDelivery,
                endDelivery,
                Theme.of(context).primaryColor,
                true),
          );
        }
      }
    }

    return meetings;
  }
}

class Event {
  Event(
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
  );

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}
