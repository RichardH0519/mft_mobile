import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/home.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class CancelContractDialog extends StatefulWidget {
  final User user;
  final int contractPrice;
  final int contractID;
  final String farmerUsername;
  final int contractNumber;

  CancelContractDialog({
    @required this.user,
    @required this.contractPrice,
    @required this.contractID,
    @required this.farmerUsername,
    @required this.contractNumber,
  });

  @override
  _CancelContractDialogState createState() => _CancelContractDialogState(
        user: user,
        contractPrice: contractPrice,
        contractID: contractID,
        farmerUsername: farmerUsername,
        contractNumber: contractNumber,
      );
}

class _CancelContractDialogState extends BaseState<CancelContractDialog> {
  final User user;
  final int contractPrice;
  final int contractID;
  final String farmerUsername;
  final int contractNumber;

  _CancelContractDialogState({
    @required this.user,
    @required this.contractPrice,
    @required this.contractID,
    @required this.farmerUsername,
    @required this.contractNumber,
  });

  final moneyFormat = NumberFormat.currency(locale: "vi", symbol: "");
  var _reasonController = TextEditingController();
  int refund;
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    refund = (contractPrice - (contractPrice * (10 / 100))).round();

    return BlocListener<ContractBloc, ContractState>(
      listener: (listenerContext, state) {
        if (state is ContractSendCancelFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("cancel_send_fail")),
              ),
            );

          Navigator.pop(context);
        }

        if (state is ContractSendCancelSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("cancel_send_success")),
              ),
            );

          BlocProvider.of<NotificationBloc>(context).add(
            CancelContractNotification(
              farmerUsername: farmerUsername,
              contractNumber: contractNumber,
            ),
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (builderContext) => Home(
                user: user,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translator.text("contract_cancel"),
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
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size10,
                    ),
                    child: Text(
                      translator.text("cancel_party"),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    user.fullname,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Dimens.size16,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.size10,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Dimens.size10,
                      ),
                      child: Text(
                        translator.text("cancel_reason"),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _cancelReasonRow(_reasonController),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.size10,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Dimens.size10,
                      ),
                      child: Text(
                        translator.text("refund"),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      "${moneyFormat.format(refund)} VND",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: Dimens.size16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          BorderButton(
            title: translator.text("cancel_request"),
            color: _isEnable ? Colors.red : Colors.grey,
            function: _isEnable
                ? () {
                    BlocProvider.of<ContractBloc>(context).add(
                      SendCancelContract(
                        contractID: contractID,
                        cancelParty: user.username,
                        cancelReason: _reasonController.text,
                        refund: refund,
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _cancelReasonRow(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.size10,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: Dimens.thick02),
        borderRadius: BorderRadius.circular(Dimens.size8),
        color: Theme.of(context).accentColor,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: TextStyle(
            color: Colors.red,
          ),
          counterText: "",
        ),
        maxLines: 2,
        textDirection: ui.TextDirection.ltr,
        controller: controller,
        style: Theme.of(context).textTheme.headline5,
        textInputAction: TextInputAction.none,
        onChanged: (value) {
          if (value != "") {
            setState(() {
              _isEnable = true;
            });
          } else {
            setState(() {
              _isEnable = false;
            });
          }
        },
      ),
    );
  }
}
