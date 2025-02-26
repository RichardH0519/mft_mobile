import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/contract/contract_api.dart';
import 'package:mft_customer_side/logic/api/exchange/exchange_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_event.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_state.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/model/notifications/customer_notification.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/exchange_management_screen.dart';
import 'package:mft_customer_side/presentation/screen/home.dart';
import 'package:mft_customer_side/presentation/screen/rented_tree_screen.dart';

class NotificationScreen extends StatefulWidget {
  final String username;
  final User user;

  NotificationScreen({@required this.username, @required this.user});

  @override
  _NotificationScreenState createState() =>
      _NotificationScreenState(username: username, user: user);
}

class _NotificationScreenState extends BaseState<NotificationScreen> {
  final String username;
  final User user;

  _NotificationScreenState({@required this.username, @required this.user});

  static final ContractRepo contractRepo = ContractRepo(
    apiClient: ContractAPI(
      httpClient: http.Client(),
    ),
  );

  static final ExchangeRepo exchangeRepo = ExchangeRepo(
    apiClient: ExchangeAPI(
      httpClient: http.Client(),
    ),
  );

  static final NotificationRepo notificationRepo = NotificationRepo(
    apiClient: NotificationAPI(),
  );

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NotificationBloc>(context).add(
      UpdateCustomerNotification(username: username),
    );

    BlocProvider.of<NotificationBloc>(context).add(
      GetCustomerNotification(
        username: username,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: Column(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size30,
                    ),
                    child: Text(
                      translator.text("notification"),
                      style: TextStyle(
                        fontSize: Dimens.size20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: Dimens.size10,
                left: Dimens.size10,
                right: Dimens.size10,
              ),
              child: SingleChildScrollView(
                child: BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, state) {
                    if (state is NotificationLoaded) {
                      List<CustomerNotification> notifications =
                          state.list.reversed.toList();

                      return Column(
                        children: [
                          for (var noti in notifications)
                            _notificationOverview(noti),
                        ],
                      );
                    }

                    if (state is NotificationEmpty) {
                      return Center(
                        child: Text(
                          translator.text(
                            "notification_empty",
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
          ),
        ],
      ),
    );
  }

  Widget _notificationOverview(CustomerNotification notification) {
    return GestureDetector(
      onTap: notification.type == "contract"
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builderContext) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ContractBloc>(
                        create: (context) => ContractBloc(
                          repo: contractRepo,
                        )..add(
                            GetContractOverviews(
                              username: user.username,
                            ),
                          ),
                      ),
                      BlocProvider<NotificationBloc>(
                        create: (blocContext) => NotificationBloc(
                          repo: notificationRepo,
                        ),
                      ),
                    ],
                    child: RentedTreeScreen(
                      user: user,
                    ),
                  ),
                ),
              );
            }
          : notification.type == "exchange"
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (routeContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider<TabsBloc>(
                            create: (blocContext) => TabsBloc(
                              repo: exchangeRepo,
                            )..add(
                                GetRequestByUsername(
                                  username: user.username,
                                ),
                              ),
                          ),
                          BlocProvider<RequestBloc>(
                            create: (blocContext) => RequestBloc(
                              repo: exchangeRepo,
                            ),
                          ),
                          BlocProvider<ResponseBloc>(
                            create: (blocContext) => ResponseBloc(
                              repo: exchangeRepo,
                            ),
                          ),
                        ],
                        child: ExchangeManagementScreen(
                          user: user,
                        ),
                      ),
                    ),
                  );
                }
              : () {},
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: Dimens.size5,
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
                Container(
                  height: Dimens.treeImage,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size20,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: notification.type == "contract"
                          ? AssetImage(
                              'assets/images/contract_icon.jpg',
                            )
                          : notification.type == "exchange"
                              ? AssetImage('assets/images/exchange_icon.png')
                              : AssetImage('assets/images/customer_icon.jpg'),
                      radius: Dimens.size30,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title, //treeCode
                        style: TextStyle(
                          fontSize: Dimens.size18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size30,
                        ),
                        child: Text(
                          DateFormat("dd/MM/yyyy   HH:mm")
                              .format(notification.created), //treeCode
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
