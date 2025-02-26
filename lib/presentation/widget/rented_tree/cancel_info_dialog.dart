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
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class CancelInfoDialog extends StatefulWidget {
  final int status;
  final String username;
  final int contractID;
  final String farmerUsername;
  final int contractNumber;

  CancelInfoDialog({
    @required this.status,
    @required this.username,
    @required this.contractID,
    @required this.farmerUsername,
    @required this.contractNumber,
  });

  @override
  _CancelInfoDialogState createState() => _CancelInfoDialogState(
        status: status,
        username: username,
        contractID: contractID,
        farmerUsername: farmerUsername,
        contractNumber: contractNumber,
      );
}

class _CancelInfoDialogState extends BaseState<CancelInfoDialog> {
  final int status;
  final String username;
  final int contractID;
  final String farmerUsername;
  final int contractNumber;

  _CancelInfoDialogState({
    @required this.status,
    @required this.username,
    @required this.contractID,
    @required this.farmerUsername,
    @required this.contractNumber,
  });

  final moneyFormat = NumberFormat.currency(locale: "vi", symbol: "");

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractBloc, ContractState>(
      listener: (listenerContext, state) {
        if (state is ContractCancelFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("cancel_contract_fail")),
              ),
            );

          Navigator.pop(context);
        }

        if (state is ContractCancelSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("cancel_contract_success")),
              ),
            );

          BlocProvider.of<NotificationBloc>(context).add(
            ConfirmCancelContractNotification(
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
              translator.text("detail"),
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
          child: BlocBuilder<ContractBloc, ContractState>(
            builder: (context, state) {
              if (state is CancelInfoLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    status != 5
                        ? Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: Dimens.size10,
                                ),
                                child: Text(
                                  translator.text("cancel_party"),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: Dimens.size14,
                                  ),
                                ),
                              ),
                              Text(
                                state.cancelInfo.cancelPartyName, //treeCode
                                style: TextStyle(
                                  fontSize: Dimens.size16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    status != 5
                        ? Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: Dimens.size10,
                                ),
                                child: Text(
                                  translator.text("cancel_reason"),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: Dimens.size14,
                                  ),
                                ),
                              ),
                              Text(
                                state.cancelInfo.cancelReason, //treeCode
                                style: TextStyle(
                                  fontSize: Dimens.size16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        : Container(),
                    status != 5
                        ? Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: Dimens.size10,
                                ),
                                child: Text(
                                  translator.text("cancel_date"),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: Dimens.size14,
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat("dd/MM/yyyy").format(
                                    state.cancelInfo.cancelDate), //gardenname
                                style: TextStyle(
                                  fontSize: Dimens.size16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: Dimens.size10,
                          ),
                          child: Text(
                            translator.text("refund"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                            ),
                          ),
                        ),
                        Text(
                          "${moneyFormat.format(state.cancelInfo.refund)} VND", //owner
                          style: TextStyle(
                            fontSize: Dimens.size16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        actions: <Widget>[
          status == 4
              ? BorderButton(
                  title: translator.text("cancel_request"),
                  color: Colors.red,
                  function: () {
                    BlocProvider.of<ContractBloc>(context).add(
                      CancelContract(
                        contractID: contractID,
                      ),
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
