import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/exchange/exchange_api.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';
import 'package:mft_customer_side/logic/bloc/package/package_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_state.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';
import 'package:mft_customer_side/presentation/screen/exchange_management_screen.dart';

class ExchangeManagementDialog extends StatefulWidget {
  final int requestID;
  final int initWeight;
  final String username;

  ExchangeManagementDialog({
    @required this.requestID,
    @required this.initWeight,
    @required this.username,
  });

  @override
  _ExchangeManagementDialogState createState() =>
      _ExchangeManagementDialogState(
          requestID: requestID, initWeight: initWeight, username: username);
}

class _ExchangeManagementDialogState
    extends BaseState<ExchangeManagementDialog> {
  final int requestID;
  final int initWeight;
  final String username;

  _ExchangeManagementDialogState({
    @required this.requestID,
    @required this.initWeight,
    @required this.username,
  });

  static final ExchangeRepo exchangeRepo = ExchangeRepo(
    apiClient: ExchangeAPI(
      httpClient: http.Client(),
    ),
  );

  final _formKey = GlobalKey<FormState>();

  //text controller
  var _weightController = TextEditingController();

  var exchangeYield;

  bool _isTooMuch = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestBloc, RequestState>(
      listener: (listenerContext, state) {
        if (state is RequestEditFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("edit_request_fail")),
              ),
            );

          Navigator.pop(context);
        }

        if (state is RequestEditSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("edit_request_success")),
              ),
            );

          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: Text(translator.text("edit_request")),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        translator.text(
                          "response_max_yield",
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    BlocBuilder<PackageBloc, PackageState>(
                      builder: (blocContext, state) {
                        if (state is YieldLoaded) {
                          exchangeYield =
                              ((state.yields.yield) * (50 / 100)).round();
                          return Text(
                            "$exchangeYield kg",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Tôi có",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size5,
                      ),
                      child: Container(
                        width: Dimens.size50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Dimens.size10,
                            ),
                            counterText: "",
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: _isTooMuch ? Colors.red : Colors.black87,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              if (num.parse(value) is int) {
                                if (num.parse(value) <= exchangeYield &&
                                    num.parse(value) != 0) {
                                  _isTooMuch = false;
                                } else {
                                  _isTooMuch = true;
                                }
                              } else {
                                _isTooMuch = true;
                              }
                            });
                          },
                          controller: _weightController,
                        ),
                      ),
                    ),
                    Text(
                      "kg muốn đổi",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
              /*call function here*/
              if ((int.parse(_weightController.text) <= exchangeYield) &&
                  int.parse(_weightController.text) != 0)
                {
                  BlocProvider.of<RequestBloc>(context).add(
                    EditRequest(
                      requestID: requestID,
                      weight: int.parse(_weightController.text),
                    ),
                  ),
                }
              else
                {}
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
