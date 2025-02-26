import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/exchange/management/management_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/management/management_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/management/management_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/model/exchange/exchange_info.dart';

class ExchangeDetailRequestDialog extends StatefulWidget {
  @override
  _ExchangeDetailRequestDialogState createState() =>
      _ExchangeDetailRequestDialogState();
}

class _ExchangeDetailRequestDialogState
    extends BaseState<ExchangeDetailRequestDialog> {
  var responseUsername;
  var plantTypename;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManagementBloc, ManagementState>(
      listener: (listenerContext, state) {
        if (state is FromRequestCancelFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("send_cancel_fail")),
              ),
            );
          Navigator.pop(context);
        }

        if (state is FromRequestCancelSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("send_cancel_success")),
              ),
            );

          BlocProvider.of<NotificationBloc>(context).add(
            RequestCancelNotification(
              responseUsername: responseUsername,
              plantTypename: plantTypename,
            ),
          );

          Navigator.pop(context);
        }

        if (state is CancelExchangeFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("cancel_exchange_fail")),
              ),
            );
          Navigator.pop(context);
        }

        if (state is CancelExchangeSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("cancel_exchange_success")),
              ),
            );

          BlocProvider.of<NotificationBloc>(context).add(
            RequestConfirmCancelNotification(
              responseUsername: responseUsername,
              plantTypename: plantTypename,
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
                "detail",
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
        content: SingleChildScrollView(
          child: BlocBuilder<ManagementBloc, ManagementState>(
            builder: (context, state) {
              if (state is ExchangeInfoByRequestIDLoaded) {
                return Column(
                  children: [
                    for (var exchange in state.exchangeInfoList.result)
                      _exchangeDetailRow(exchange),
                  ],
                );
              }

              if (state is ExchangeInfoByRequestIDEmpty) {
                return Center(
                  child: Text(
                    translator.text("list_empty"),
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _exchangeDetailRow(ExchangeInfo exchange) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Dimens.size10,
      ),
      child: Material(
        elevation: Dimens.cardElevation,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(width: Dimens.thick02),
            borderRadius: BorderRadius.circular(
              Dimens.size5,
            ),
          ),
          padding: const EdgeInsets.all(
            Dimens.size10,
          ),
          child: _detailColumn(exchange),
        ),
      ),
    );
  }

  Widget _detailColumn(ExchangeInfo exchange) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("request_side"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  exchange.requestFullname,
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("phone"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  exchange.requestPhone,
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("receive"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${exchange.weight} kg",
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("plant_type"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  exchange.responsePlant,
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("response_side"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  exchange.responseFullname,
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("phone"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  exchange.responsePhone,
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("receive"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${exchange.requestWeight} kg",
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("plant_type"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  exchange.requestPlant, //treePrice
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("request_status"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: _turnBooltoWidget(exchange.mag.requestReceived),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("response_status"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: _turnBooltoWidget(exchange.mag.responseReceived),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("exchange_status"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: _textByStatus(exchange),
              ),
            ],
          ),
        ),
        _buttonByStatus(exchange),
      ],
    );
  }

  Widget _turnBooltoWidget(bool status) {
    if (status == false) {
      return Text(
        translator.text('not_receive'),
        style: TextStyle(
          fontSize: Dimens.size16,
          color: Colors.orange.shade600,
        ),
      );
    } else if (status == true) {
      return Text(
        translator.text("received"),
        style: TextStyle(
          fontSize: Dimens.size16,
          color: Colors.green,
        ),
      );
    }
  }

  Widget _textByStatus(ExchangeInfo exchangeInfo) {
    switch (exchangeInfo.mag.status) {
      case 0:
        if ((exchangeInfo.mag.responseReceived == true) &&
            (exchangeInfo.mag.requestReceived == true)) {
          return Text(
            translator.text(
              "done",
            ),
            style: TextStyle(
              fontSize: Dimens.size16,
              color: Colors.purple,
            ),
          );
        } else {
          return Text(
            translator.text(
              "active",
            ),
            style: TextStyle(
              fontSize: Dimens.size16,
              color: Colors.green,
            ),
          );
        }

        break;

      case 1:
        return Text(
          translator.text(
            "waiting_cancel",
          ),
          style: TextStyle(
            fontSize: Dimens.size16,
            color: Colors.orange.shade600,
          ),
        );
        break;

      case 2:
        return Text(
          translator.text(
            "waiting_cancel",
          ),
          style: TextStyle(
            fontSize: Dimens.size16,
            color: Colors.orange.shade600,
          ),
        );
        break;

      case 3:
        return Text(
          translator.text(
            "cancel",
          ),
          style: TextStyle(
            fontSize: Dimens.size16,
            color: Colors.red,
          ),
        );
        break;
    }
  }

  Widget _buttonByStatus(ExchangeInfo exchangeInfo) {
    switch (exchangeInfo.mag.status) {
      case 0:
        if (((exchangeInfo.mag.responseReceived == true) &&
                (exchangeInfo.mag.requestReceived == true)) ||
            (exchangeInfo.mag.responseReceived == true)) {
          return Container();
        } else {
          return ElevatedButton(
            onPressed: () {
              responseUsername = exchangeInfo.responseUsername;
              plantTypename = exchangeInfo.responsePlant;

              BlocProvider.of<ManagementBloc>(context).add(
                FromRequestCancel(
                  managementID: exchangeInfo.mag.id,
                ),
              );
            },
            child: Text(
              translator.text("cancel_exchange"),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
          );
        }

        break;

      case 1:
        return Container();
        break;

      case 2:
        return ElevatedButton(
          onPressed: () {
            responseUsername = exchangeInfo.responseUsername;
            plantTypename = exchangeInfo.responsePlant;

            BlocProvider.of<ManagementBloc>(context).add(
              CancelExchange(
                requestID: exchangeInfo.mag.requestID,
                responseID: exchangeInfo.mag.responseID,
                managementID: exchangeInfo.mag.id,
              ),
            );
          },
          child: Text(
            translator.text("confirm_contract"),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
        );
        break;

      case 3:
        return Container();
        break;
    }
  }
}
