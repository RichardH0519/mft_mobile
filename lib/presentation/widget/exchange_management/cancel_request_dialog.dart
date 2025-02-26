import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';

class CancelRequestDialog extends StatefulWidget {
  final int requestID;

  CancelRequestDialog({@required this.requestID});

  @override
  _CancelRequestDialogState createState() =>
      _CancelRequestDialogState(requestID: requestID);
}

class _CancelRequestDialogState extends BaseState<CancelRequestDialog> {
  final int requestID;

  _CancelRequestDialogState({@required this.requestID});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestBloc, RequestState>(
      listener: (listenerContext, state) {
        if (state is RequestCancelFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("cancel_request_fail")),
              ),
            );
          Navigator.pop(context);
        }

        if (state is RequestCancelSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("cancel_request_success")),
              ),
            );
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: Text(translator.text("alert")),
        content: Text(translator.text("request_cancel_ensure")),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            child: Text(
              translator.text("declined"),
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          TextButton(
            onPressed: () => {
              BlocProvider.of<RequestBloc>(context).add(
                CancelRequest(
                  requestID: requestID,
                ),
              ),
            },
            child: Text(
              translator.text("approved"),
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
