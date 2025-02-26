import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';
import 'package:mft_customer_side/logic/bloc/package/package_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_state.dart';

class ExchangeDialog extends StatefulWidget {
  final int plantTypeID;
  final int contractID;
  final String username;

  ExchangeDialog(
      {@required this.plantTypeID,
      @required this.contractID,
      @required this.username});

  @override
  _ExchangeDialogState createState() => _ExchangeDialogState(
      plantTypeID: plantTypeID, contractID: contractID, username: username);
}

class _ExchangeDialogState extends BaseState<ExchangeDialog> {
  final int plantTypeID;
  final int contractID;
  final String username;

  _ExchangeDialogState(
      {@required this.plantTypeID,
      @required this.contractID,
      @required this.username});

  final _formKey = GlobalKey<FormState>();

  //text controller
  var _weightController = TextEditingController();

  var exchangeYield;

  bool _isTooMuch = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestBloc, RequestState>(
      listener: (listenerContext, state) {
        if (state is RequestCreateFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("add_request_fail")),
              ),
            );

          Navigator.pop(context);
        }

        if (state is RequestCreateSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("add_request_success")),
              ),
            );
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: Text(translator.text("create_request")),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    CreateRequest(
                      plantTypeID: plantTypeID,
                      weight: int.parse(_weightController.text),
                      contractID: contractID,
                      username: username,
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
