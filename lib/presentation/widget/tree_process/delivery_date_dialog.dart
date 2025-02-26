import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract-detail_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract_detail_event.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract_detail_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class DeliveryDateDialog extends StatefulWidget {
  final int contractID;

  final DateTime startDate;
  final DateTime endDate;

  final String farmerUsername;
  final int contractNumber;

  DeliveryDateDialog({
    @required this.contractID,
    @required this.startDate,
    @required this.endDate,
    @required this.farmerUsername,
    @required this.contractNumber,
  });

  @override
  _DeliveryDateDialogState createState() => _DeliveryDateDialogState(
        contractID: contractID,
        startDate: startDate,
        endDate: endDate,
        farmerUsername: farmerUsername,
        contractNumber: contractNumber,
      );
}

class _DeliveryDateDialogState extends BaseState<DeliveryDateDialog> {
  final int contractID;

  final DateTime startDate;
  final DateTime endDate;

  final String farmerUsername;
  final int contractNumber;

  _DeliveryDateDialogState({
    @required this.contractID,
    @required this.startDate,
    @required this.endDate,
    @required this.farmerUsername,
    @required this.contractNumber,
  });

  var _chosenDate = "";
  var _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractDetailBloc, ContractDetailState>(
      listener: (listenerContext, state) {
        if (state is SendContractDetailFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("delivery_date_send_fail")),
              ),
            );
          Navigator.pop(context);
        }

        if (state is SendContractDetailSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("delivery_date_send_success")),
              ),
            );

          BlocProvider.of<NotificationBloc>(context).add(
            ChooseDeliveryDateNotification(
              farmerUsername: farmerUsername,
              contractNumber: contractNumber,
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
              translator.text(
                "delivery_date_booking",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
              ),
            ),
          ],
        ),
        content: _dateRow(_chosenDate),
        actions: <Widget>[
          BorderButton(
            title: translator.text("booking"),
            color: _isEnable ? Theme.of(context).primaryColor : Colors.grey,
            function: _isEnable
                ? () {
                    BlocProvider.of<ContractDetailBloc>(context).add(
                      SendDeliveryDate(
                        contractID: contractID,
                        deliveryDate: _chosenDate,
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
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(startDate.year, startDate.month, startDate.day),
          maxTime: DateTime(endDate.year, endDate.month, endDate.day),
          onConfirm: (date) {
            setState(() {
              _chosenDate = DateFormat("yyyy-MM-dd").format(date);
              _isEnable = true;
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
                translator.text("delivery_date_receive"),
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
}
