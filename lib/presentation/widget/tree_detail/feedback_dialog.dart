import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/feedback/feedback_bloc.dart';
import 'package:mft_customer_side/logic/bloc/feedback/feedback_event.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class FeedbackDialog extends StatefulWidget {
  final String customerUsername;
  final String farmerUsername;

  FeedbackDialog(
      {@required this.customerUsername, @required this.farmerUsername});

  @override
  _FeedbackDialogState createState() => _FeedbackDialogState(
        customerUsername: customerUsername,
        farmerUsername: farmerUsername,
      );
}

class _FeedbackDialogState extends BaseState<FeedbackDialog> {
  final String customerUsername;
  final String farmerUsername;

  _FeedbackDialogState(
      {@required this.customerUsername, @required this.farmerUsername});

  var _reasonController = TextEditingController();
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            translator.text("farmer_feedback"),
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
                      translator.text("reason"),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _reasonRow(_reasonController),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        BorderButton(
          title: translator.text("send"),
          color: _isEnable ? Colors.blue : Colors.grey,
          function: _isEnable
              ? () {
                  BlocProvider.of<FeedbackBloc>(context).add(
                    SendFeedback(
                      customerUsername: customerUsername,
                      farmerUsername: farmerUsername,
                      feedback: _reasonController.text,
                    ),
                  );

                  Navigator.pop(context);
                }
              : null,
        ),
      ],
    );
  }

  Widget _reasonRow(TextEditingController controller) {
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
        maxLines: 5,
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
