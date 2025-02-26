import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/model/exchange/exchange_response.dart';

class ResponseToRequestDialog extends StatefulWidget {
  final int requestID;

  ResponseToRequestDialog({@required this.requestID});

  @override
  _ResponseToRequestDialogState createState() =>
      _ResponseToRequestDialogState(requestID: requestID);
}

class _ResponseToRequestDialogState extends BaseState<ResponseToRequestDialog> {
  final int requestID;

  _ResponseToRequestDialogState({@required this.requestID});

  var responseUsername;
  var plantTypename;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestBloc, RequestState>(
      listener: (context, state) {
        if (state is AcceptExchangeSuccess) {
          BlocProvider.of<NotificationBloc>(context).add(
            AcceptResponseNotification(
              responseUsername: responseUsername,
              plantTypename: plantTypename,
            ),
          );
        }

        if (state is ResponseRejectSuccess) {
          BlocProvider.of<NotificationBloc>(context).add(
            RejectResponseNotification(
              responseUsername: responseUsername,
              plantTypename: plantTypename,
            ),
          );
        }
      },
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translator.text(
                "response_list",
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
          child: BlocBuilder<RequestBloc, RequestState>(
            builder: (context, state) {
              if (state is AllResponseLoaded) {
                return Column(
                  children: [
                    for (var response in state.responseList.result)
                      _responseRow(response),
                  ],
                );
              }

              if (state is RequestListEmpty) {
                return Center(
                  child: Text(
                    translator.text(
                      "list_empty",
                    ),
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

  Widget _responseRow(ExchangeResponse response) {
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
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimens.treeImage,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: Dimens.size20,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        child: const Icon(
                          Icons.person,
                          size: Dimens.size35,
                        ),
                        radius: Dimens.size25,
                      ),
                      //add img later //null checking
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          response.responseName, //treeCode
                          style: TextStyle(
                            fontSize: Dimens.size18,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: Dimens.size20,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: Dimens.size10,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: "Đổi",
                                style: TextStyle(
                                  fontSize: Dimens.size16,
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        " ${response.responseWeight.toString()}",
                                    style: TextStyle(
                                      fontSize: Dimens.size18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " kg",
                                  ),
                                  TextSpan(
                                    text: " ${response.responsePlantName}",
                                    style: TextStyle(
                                      fontSize: Dimens.size18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " lấy",
                                  ),
                                  TextSpan(
                                    text:
                                        " ${response.requestWeight.toString()}",
                                    style: TextStyle(
                                      fontSize: Dimens.size18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " kg",
                                  ),
                                  TextSpan(
                                    text: " ${response.requestPlantName}",
                                    style: TextStyle(
                                      fontSize: Dimens.size18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimens.size5,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        responseUsername = response.responseUsername;
                        plantTypename = response.requestPlantName;

                        BlocProvider.of<RequestBloc>(context).add(
                          AcceptExchange(
                            requestID: requestID,
                            responseID: response.id,
                          ),
                        );
                        BlocProvider.of<RequestBloc>(context).add(
                          GetAllResponse(
                            requestID: requestID,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        translator.text("approved"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimens.size5,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        responseUsername = response.responseUsername;
                        plantTypename = response.requestPlantName;

                        BlocProvider.of<RequestBloc>(context).add(
                          RejectResponse(
                            responseID: response.id,
                          ),
                        );
                        BlocProvider.of<RequestBloc>(context).add(
                          GetAllResponse(
                            requestID: requestID,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text(
                        translator.text("declined"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
