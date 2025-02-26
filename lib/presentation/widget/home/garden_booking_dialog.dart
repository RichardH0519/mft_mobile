import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_bloc.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_event.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_state.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class GardenBookingDialog extends StatefulWidget {
  final String username;
  final int gardenID;
  final String farmerUsername;
  final String customerFullname;
  final String gardenName;

  GardenBookingDialog({
    @required this.username,
    @required this.gardenID,
    @required this.farmerUsername,
    @required this.customerFullname,
    @required this.gardenName,
  });

  @override
  _GardenBookingDialogState createState() => _GardenBookingDialogState(
        username: username,
        gardenID: gardenID,
        farmerUsername: farmerUsername,
        customerFullname: customerFullname,
        gardenName: gardenName,
      );
}

class _GardenBookingDialogState extends BaseState<GardenBookingDialog> {
  final String username;
  final int gardenID;
  final String farmerUsername;
  final String customerFullname;
  final String gardenName;

  _GardenBookingDialogState({
    @required this.username,
    @required this.gardenID,
    @required this.farmerUsername,
    @required this.customerFullname,
    @required this.gardenName,
  });

  var _chosenDate = "";
  var _chosenTime = "";
  var _visitDate;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisitingBloc, VisitingState>(
      listener: (listenerContext, state) {
        if (state is BookVisitFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("book_garden_fail")),
              ),
            );

          Navigator.pop(context);
        }

        if (state is BookVisitSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("book_garden_success")),
              ),
            );

          BlocProvider.of<NotificationBloc>(context).add(
            BookVisitNotification(
              farmerUsername: farmerUsername,
              customerFullname: customerFullname,
              gardenName: gardenName,
            ),
          );

          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translator.text("visit_garden_booking"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _dateRow(_chosenDate),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.size10,
                ),
                child: _timeRow(_chosenTime),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          BorderButton(
            title: translator.text("booking"),
            color: (_chosenDate != "" && _chosenTime != "")
                ? Theme.of(context).primaryColor
                : Colors.grey,
            function: (_chosenDate != "" && _chosenTime != "")
                ? () {
                    _visitDate = "${_chosenDate}T${_chosenTime}";

                    BlocProvider.of<VisitingBloc>(context).add(
                      BookAVisit(
                        visitDate: _visitDate,
                        customerUsername: username,
                        gardenID: gardenID,
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _dateRow(String date) {
    final maxDay = DateTime.now().day;
    final maxMonth = DateTime.now().month;
    final minYear = DateTime.now().year;
    final maxYear = DateTime.now().year;
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(minYear, maxMonth, maxDay),
          maxTime: DateTime(maxYear, 12, 31),
          onConfirm: (date) {
            setState(() {
              _chosenDate = DateFormat("yyyy-MM-dd").format(date);
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.vi,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.size20),
        decoration: BoxDecoration(
          border: Border.all(width: Dimens.thick02),
          borderRadius: BorderRadius.circular(Dimens.size8),
          color: Theme.of(context).accentColor,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
              child: Icon(Icons.date_range),
            ),
            Padding(
              padding: const EdgeInsets.only(right: Dimens.size20),
              child: Text(
                translator.text("visit_date"),
                style: TextStyle(
                  fontSize: Dimens.size16,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              date,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeRow(String time) {
    return GestureDetector(
      onTap: () {
        DatePicker.showTimePicker(
          context,
          showTitleActions: true,
          showSecondsColumn: false,
          onConfirm: (time) {
            setState(() {
              _chosenTime = DateFormat.Hm().format(time);
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.vi,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.size20),
        decoration: BoxDecoration(
          border: Border.all(width: Dimens.thick02),
          borderRadius: BorderRadius.circular(Dimens.size8),
          color: Theme.of(context).accentColor,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
              child: Icon(Icons.access_time),
            ),
            Padding(
              padding: const EdgeInsets.only(right: Dimens.size20),
              child: Text(
                translator.text("visit_time"),
                style: TextStyle(
                  fontSize: Dimens.size16,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
