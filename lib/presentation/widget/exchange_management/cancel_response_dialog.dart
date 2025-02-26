import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_state.dart';

class CancelResponseDialog extends StatefulWidget {
  final int responseID;

  CancelResponseDialog({@required this.responseID});

  @override
  _CancelResponseDialogState createState() =>
      _CancelResponseDialogState(responseID: responseID);
}

class _CancelResponseDialogState extends BaseState<CancelResponseDialog> {
  final int responseID;

  _CancelResponseDialogState({@required this.responseID});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResponseBloc, ResponseState>(
      listener: (listenerContext, state) {
        if (state is ResponseCancelFail) {
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

        if (state is ResponseCancelSuccess) {
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
        title: Text(translator.text("tree_detail")),
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
              BlocProvider.of<ResponseBloc>(context).add(
                CancelResponse(
                  responseID: responseID,
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
