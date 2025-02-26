import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/contract/contract_api.dart';
import 'package:mft_customer_side/logic/api/exchange/exchange_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/package/pakage_api.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_rate/contract_rate_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_rate/contract_rate_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/management/management_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/management/management_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_event.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/package/package_repo.dart';
import 'package:mft_customer_side/model/exchange/exchange_request.dart';
import 'package:mft_customer_side/model/exchange/exchange_response.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/response_screen_edit.dart';
import 'package:mft_customer_side/presentation/widget/exchange_management/cancel_request_dialog.dart';
import 'package:mft_customer_side/presentation/widget/exchange_management/cancel_response_dialog.dart';
import 'package:mft_customer_side/presentation/widget/exchange_management/exchange_detail_request_dialog.dart';
import 'package:mft_customer_side/presentation/widget/exchange_management/exchange_detail_response_dialog.dart';
import 'package:mft_customer_side/presentation/widget/exchange_management/exchange_management_dialog.dart';
import 'package:mft_customer_side/presentation/widget/exchange_management/response_to_request_dialog.dart';

class ExchangeManagementScreen extends StatefulWidget {
  final User user;

  ExchangeManagementScreen({@required this.user});

  @override
  _ExchangeManagementScreenState createState() =>
      _ExchangeManagementScreenState(user: user);
}

class _ExchangeManagementScreenState
    extends BaseState<ExchangeManagementScreen> {
  final User user;

  _ExchangeManagementScreenState({@required this.user});

  static final PackageRepo packageRepo = PackageRepo(
    apiClient: PackageAPI(
      httpClient: http.Client(),
    ),
  );

  static final ExchangeRepo exchangeRepo = ExchangeRepo(
    apiClient: ExchangeAPI(
      httpClient: http.Client(),
    ),
  );

  static final ContractRepo contractRepo = ContractRepo(
    apiClient: ContractAPI(
      httpClient: http.Client(),
    ),
  );

  static final NotificationRepo notificationRepo = NotificationRepo(
    apiClient: NotificationAPI(),
  );

  bool _isRequestActive = true;
  bool _isResponseActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: Dimens.thick05,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  Dimens.size20,
                ),
                bottomRight: Radius.circular(
                  Dimens.size20,
                ),
              ),
              color: CustomColors.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: Dimens.size35,
                bottom: Dimens.size15,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.size15,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: Dimens.size30,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.size80,
                    ),
                    child: Text(
                      translator.text("request_management"),
                      style: TextStyle(
                        fontSize: Dimens.size20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size20,
              left: Dimens.size15,
              right: Dimens.size15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isRequestActive = true;
                      _isResponseActive = false;
                      BlocProvider.of<TabsBloc>(context).add(
                        GetRequestByUsername(
                          username: user.username,
                        ),
                      );
                    });
                  },
                  child: Text(
                    translator.text("request_list"),
                    style: TextStyle(
                        fontSize: Dimens.size18,
                        fontWeight: FontWeight.w500,
                        color: _isRequestActive
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isResponseActive = true;
                      _isRequestActive = false;
                      BlocProvider.of<TabsBloc>(context).add(
                        GetResponseByUsername(
                          username: user.username,
                        ),
                      );
                    });
                  },
                  child: Text(
                    translator.text("response_list"),
                    style: TextStyle(
                      fontSize: Dimens.size18,
                      fontWeight: FontWeight.w500,
                      color: _isResponseActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimens.size10,
                right: Dimens.size10,
                top: Dimens.size15,
              ),
              child: SingleChildScrollView(
                child: BlocBuilder<TabsBloc, TabsState>(
                  builder: (builderContext, state) {
                    if (state is RequestListLoaded) {
                      return Column(
                        children: [
                          for (var request in state.requestList.result.reversed)
                            _requestOverview(request),
                        ],
                      );
                    }

                    if (state is ResponseListLoaded) {
                      return Column(
                        children: [
                          for (var response in state.responseList.result.reversed)
                            _responseOverview(response),
                        ],
                      );
                    }

                    if (state is ListEmpty) {
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
          ),
        ],
      ),
    );
  }

  Widget _requestOverview(ExchangeRequest request) {
    return GestureDetector(
      onTap: request.status == 0
          ? () {
              showDialog(
                context: context,
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<RequestBloc>(
                      create: (blocContext) => RequestBloc(
                        repo: exchangeRepo,
                      )..add(
                          GetAllResponse(
                            requestID: request.id,
                          ),
                        ),
                    ),
                    BlocProvider<NotificationBloc>(
                      create: (blocContext) => NotificationBloc(
                        repo: notificationRepo,
                      ),
                    ),
                  ],
                  child: ResponseToRequestDialog(
                    requestID: request.id,
                  ),
                ),
              ).then((_) {
                BlocProvider.of<TabsBloc>(context).add(
                  GetRequestByUsername(
                    username: request.username,
                  ),
                );
              });
            }
          : () {},
      child: Padding(
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size40,
                          bottom: Dimens.size40,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: Dimens.size10,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: "Tôi có",
                              style: TextStyle(
                                fontSize: Dimens.size16,
                                color: Colors.black87,
                              ),
                              children: [
                                TextSpan(
                                  text: " ${request.weight.toString()}",
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
                                  text: " ${request.plantTypeName}",
                                  style: TextStyle(
                                    fontSize: Dimens.size18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: " muốn trao đổi",
                                ),
                              ],
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat("dd-MM-yyyy")
                            .format(request.date), //treeCode
                        style: TextStyle(
                          fontSize: Dimens.size18,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                _returnButtonColumnByRequestStatus(request),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _returnButtonColumnByRequestStatus(ExchangeRequest request) {
    switch (request.status) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.size5,
              ),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ManagementBloc>(
                          create: (blocContext) => ManagementBloc(
                            repo: exchangeRepo,
                          )..add(
                              GetExchangeInfoByRequestID(
                                requestID: request.id,
                              ),
                            ),
                        ),
                        BlocProvider<NotificationBloc>(
                          create: (blocContext) => NotificationBloc(
                            repo: notificationRepo,
                          ),
                        ),
                      ],
                      child: ExchangeDetailRequestDialog(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text(
                  translator.text("detail"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.size5,
              ),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<PackageBloc>(
                          create: (blocContext) =>
                              PackageBloc(repo: packageRepo)
                                ..add(
                                  GetYield(
                                    username: request.username,
                                    contractID: request.contractID,
                                  ),
                                ),
                        ),
                        BlocProvider<RequestBloc>(
                          create: (blocContext) => RequestBloc(
                            repo: exchangeRepo,
                          ),
                        ),
                      ],
                      child: ExchangeManagementDialog(
                        requestID: request.id,
                        initWeight: request.weight,
                        username: request.username,
                      ),
                    ),
                  ).then((_) {
                    BlocProvider.of<TabsBloc>(context).add(
                      GetRequestByUsername(
                        username: request.username,
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade600,
                ),
                child: Text(
                  translator.text("update"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.size5,
              ),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<RequestBloc>(
                          create: (blocContext) => RequestBloc(
                            repo: exchangeRepo,
                          ),
                        ),
                      ],
                      child: CancelRequestDialog(
                        requestID: request.id,
                      ),
                    ),
                  ).then((_) {
                    BlocProvider.of<TabsBloc>(context).add(
                      GetRequestByUsername(
                        username: request.username,
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  translator.text("cancel_request"),
                ),
              ),
            ),
          ],
        );

        break;

      case 1:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.size50,
              ),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ManagementBloc>(
                          create: (blocContext) => ManagementBloc(
                            repo: exchangeRepo,
                          )..add(
                              GetExchangeInfoByRequestID(
                                requestID: request.id,
                              ),
                            ),
                        ),
                        BlocProvider<NotificationBloc>(
                          create: (blocContext) => NotificationBloc(
                            repo: notificationRepo,
                          ),
                        ),
                      ],
                      child: ExchangeDetailRequestDialog(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text(
                  translator.text("detail"),
                ),
              ),
            ),
          ],
        );

        break;
    }
  }

  Widget _responseOverview(ExchangeResponse response) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              text: "Tôi đã yêu cầu đổi",
                              style: TextStyle(
                                fontSize: Dimens.size16,
                                color: Colors.black87,
                              ),
                              children: [
                                TextSpan(
                                  text: " ${response.responseWeight}",
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
                                  text: " với",
                                ),
                                TextSpan(
                                  text: " ${response.requestWeight}",
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size20,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: Dimens.size10,
                              ),
                              child: Text(
                                translator.text("trade_with"),
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Text(
                              response.requestName,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: Dimens.size16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size20,
                        ),
                        child: Text(
                          DateFormat("dd-MM-yyyy")
                              .format(response.date), //treeCode
                          style: TextStyle(
                            fontSize: Dimens.size18,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _returnButtonColumByResponseStatus(response)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _returnButtonColumByResponseStatus(ExchangeResponse response) {
    switch (response.status) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.size15,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (routeContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider<ContractBloc>(
                            create: (blocContext) => ContractBloc(
                              repo: contractRepo,
                            )..add(
                                GetContractOverviews(
                                  username: user.username,
                                ),
                              ),
                          ),
                          BlocProvider<ContractRateBloc>(
                            create: (blocContext) => ContractRateBloc(
                              repo: contractRepo,
                            )..add(
                                GetContractRate(
                                  requestID: response.exchangeRequestID,
                                ),
                              ),
                          ),
                          BlocProvider<PackageBloc>(
                            create: (blocContext) =>
                                PackageBloc(repo: packageRepo),
                          ),
                          BlocProvider<ResponseBloc>(
                            create: (blocContext) => ResponseBloc(
                              repo: exchangeRepo,
                            )..add(
                                GetRequestWeight(
                                  responseID: response.id,
                                ),
                              ),
                          ),
                        ],
                        child: ResponseScreenEdit(
                          plantTypeName: response.requestPlantName,
                          exchangeRequestID: response.exchangeRequestID,
                          username: user.username,
                          responseID: response.id,
                        ),
                      ),
                    ),
                  ).then((_) {
                    BlocProvider.of<TabsBloc>(context).add(
                      GetResponseByUsername(
                        username: user.username,
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade600,
                ),
                child: Text(
                  translator.text("update"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.size15,
              ),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ResponseBloc>(
                          create: (blocContext) =>
                              ResponseBloc(repo: exchangeRepo),
                        ),
                      ],
                      child: CancelResponseDialog(
                        responseID: response.id,
                      ),
                    ),
                  ).then((_) {
                    BlocProvider.of<TabsBloc>(context).add(
                      GetResponseByUsername(
                        username: user.username,
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  translator.text("cancel_request"),
                ),
              ),
            ),
          ],
        );

        break;

      case 1:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.size50,
              ),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ManagementBloc>(
                          create: (blocContext) => ManagementBloc(
                            repo: exchangeRepo,
                          )..add(
                              GetExchangeInfoByResponseID(
                                responseID: response.id,
                              ),
                            ),
                        ),
                        BlocProvider<NotificationBloc>(
                          create: (blocContext) => NotificationBloc(
                            repo: notificationRepo,
                          ),
                        ),
                      ],
                      child: ExchangeDetailResponseDialog(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text(
                  translator.text("detail"),
                ),
              ),
            ),
          ],
        );

        break;
    }
  }
}
