import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/garden/garden_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/package/pakage_api.dart';
import 'package:mft_customer_side/logic/api/plant_type/plant_type_api.dart';
import 'package:mft_customer_side/logic/api/tree/tree_api.dart';
import 'package:mft_customer_side/logic/api/visiting/visiting_api.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_bloc.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_event.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_state.dart';
import 'package:mft_customer_side/logic/bloc/package/package_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_event.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_bloc.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_event.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_state.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_bloc.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_event.dart';
import 'package:mft_customer_side/logic/repo/garden/garden_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/package/package_repo.dart';
import 'package:mft_customer_side/logic/repo/plant_type/plant_type_repo.dart';
import 'package:mft_customer_side/logic/repo/tree/tree_repo.dart';
import 'package:mft_customer_side/logic/repo/visiting/visiting_repo.dart';
import 'package:mft_customer_side/model/garden/garden.dart';
import 'package:mft_customer_side/model/notifications/customer_notification.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/calendar_screen.dart';
import 'package:mft_customer_side/presentation/screen/garden_detail_screen.dart';
import 'package:mft_customer_side/presentation/screen/notification_screen.dart';
import 'package:mft_customer_side/presentation/screen/search_screen.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';
import 'package:mft_customer_side/presentation/widget/home/garden_booking_dialog.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({@required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState(user: user);
}

class _HomeScreenState extends BaseState<HomeScreen> {
  final User user;

  _HomeScreenState({@required this.user});

  static final TreeRepo treeRepo = TreeRepo(
    apiClient: TreeAPI(
      httpClient: http.Client(),
    ),
  );

  static final PlantTypeRepo plantTypeRepo = PlantTypeRepo(
    apiClient: PlantTypeAPI(
      httpClient: http.Client(),
    ),
  );

  static final GardenRepo gardenRepo = GardenRepo(
    apiClient: GardenAPI(
      httpClient: http.Client(),
    ),
  );

  static final VisitingRepo visitingRepo = VisitingRepo(
    apiClient: VisitingAPI(
      httpClient: http.Client(),
    ),
  );

  static final PackageRepo packageRepo = PackageRepo(
    apiClient: PackageAPI(
      httpClient: http.Client(),
    ),
  );

  static final NotificationRepo notificationRepo = NotificationRepo(
    apiClient: NotificationAPI(),
  );

  bool _isEnable = false;
  var customerFullname;

  final customerDatabaseRef =
      FirebaseDatabase.instance.reference().child("notificationApp");

  @override
  void initState() {
    // TODO: implement initState
    customerDatabaseRef.onChildAdded.listen(
      (event) {
        BlocProvider.of<NotificationBloc>(context).add(
          GetCustomerNotification(
            username: user.username,
          ),
        );
      },
    );

    BlocProvider.of<NotificationBloc>(context).add(
      GetCustomerNotification(
        username: user.username,
      ),
    );
    super.initState();
  }

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
                top: Dimens.size30,
                bottom: Dimens.size15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Dimens.size20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translator.text("hello"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white60,
                            ),
                          ),
                          BlocBuilder<UserInfoBloc, UserInfoState>(
                            builder: (context, state) {
                              if (state is UserInfoLoaded) {
                                customerFullname = state.user.fullname;

                                return Text(
                                  state.user.fullname,
                                  style: TextStyle(
                                    fontSize: Dimens.size20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                );
                              }

                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (routeContext) => MultiBlocProvider(
                              providers: [
                                BlocProvider<PlantTypeBloc>(
                                  create: (blocContext) => PlantTypeBloc(
                                    repo: plantTypeRepo,
                                  )..add(
                                      GetPlantType(),
                                    ),
                                ),
                                BlocProvider<GardenBloc>(
                                  create: (blocContext) => GardenBloc(
                                    repo: gardenRepo,
                                  ),
                                ),
                              ],
                              child: SearchScreen(
                                user: user,
                                customerFullname: customerFullname,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.search,
                        size: Dimens.size25,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builderContext) => MultiBlocProvider(
                              providers: [
                                BlocProvider<VisitingBloc>(
                                  create: (blocContext) => VisitingBloc(
                                    repo: visitingRepo,
                                  )..add(
                                      GetVisitSchedule(
                                        username: user.username,
                                      ),
                                    ),
                                ),
                                BlocProvider<PackageBloc>(
                                  create: (blocContext) => PackageBloc(
                                    repo: packageRepo,
                                  )..add(
                                      GetDeliverySchedule(
                                        username: user.username,
                                      ),
                                    ),
                                ),
                              ],
                              child: CalendarScreen(),
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.calendar_today,
                        size: Dimens.size25,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size15,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builderContext) => MultiBlocProvider(
                              providers: [
                                BlocProvider<NotificationBloc>(
                                  create: (blocContext) => NotificationBloc(
                                    repo: notificationRepo,
                                  ),
                                ),
                              ],
                              child: NotificationScreen(
                                username: user.username,
                                user: user,
                              ),
                            ),
                          ),
                        ).then(
                          (value) {
                            BlocProvider.of<NotificationBloc>(context).add(
                              GetCustomerNotification(
                                username: user.username,
                              ),
                            );
                          },
                        );
                      },
                      child: BlocBuilder<NotificationBloc, NotificationState>(
                        builder: (context, state) {
                          if (state is NotificationLoaded) {
                            return _returnUnreadNotiNumber(state.list) > 0
                                ? Badge(
                                    badgeContent: Text(
                                      _returnUnreadNotiNumber(state.list)
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.notifications,
                                      size: Dimens.size25,
                                      color: Colors.white60,
                                    ),
                                  )
                                : Icon(
                                    Icons.notifications,
                                    size: Dimens.size25,
                                    color: Colors.white60,
                                  );
                          }

                          return Icon(
                            Icons.notifications,
                            size: Dimens.size25,
                            color: Colors.white60,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size30,
              left: Dimens.size15,
              right: Dimens.size15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translator.text("garden_list"),
                  style: TextStyle(
                    fontSize: Dimens.size18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEnable = !_isEnable;
                    });

                    if (_isEnable == true) {
                      //call get garden by interest
                      BlocProvider.of<GardenBloc>(context).add(
                        GetAllGardenByInterest(username: user.username),
                      );
                    } else {
                      BlocProvider.of<GardenBloc>(context).add(
                        GetAllGarden(),
                      );
                    }
                  },
                  child: Text(
                    translator.text(
                      "sort_by_interest",
                    ),
                    style: TextStyle(
                      color: _isEnable ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: Dimens.size20,
                left: Dimens.size10,
                right: Dimens.size10,
              ),
              child: SingleChildScrollView(
                child: BlocBuilder<GardenBloc, GardenState>(
                  builder: (blocContext, state) {
                    if (state is GardenLoaded) {
                      return Column(
                        children: [
                          for (var garden in state.gardenList.result)
                            _gardenOverview(
                              garden: garden,
                              user: user,
                            ),
                        ],
                      );
                    }

                    if (state is GardenByInterestLoaded) {
                      return Column(
                        children: [
                          for (var garden in state.gardenList.result)
                            _gardenOverview(
                              garden: garden,
                              user: user,
                            ),
                        ],
                      );
                    }

                    if (state is GardenEmpty) {
                      return Center(
                        child: Text(
                          translator.text("no_garden"),
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

  Widget _gardenOverview({Garden garden, User user}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builderContext) => BlocProvider(
              create: (blocContext) => TreeBloc(repo: treeRepo)
                ..add(
                  GetAllTree(
                    gardenID: garden.id,
                  ),
                ),
              child: GardenDetailScreen(
                user: user,
                garden: garden,
              ),
            ),
          ),
        );
      },
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  garden.gardenName, //gardenName
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size20,
                  ),
                ),
                Text(
                  garden.plantTypeName, //plantTypeName
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                    fontSize: Dimens.size18,
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
                          translator.text("owner"),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: Dimens.size14,
                          ),
                        ),
                      ),
                      Text(
                        garden.fullname, //ownerName
                        style: TextStyle(
                          fontSize: Dimens.size16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.size5,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: Dimens.size10,
                        ),
                        child: Text(
                          translator.text("address"),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: Dimens.size14,
                          ),
                        ),
                      ),
                      Text(
                        garden.address, //gardenAddress
                        style: TextStyle(
                          fontSize: Dimens.size16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.size5,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: Dimens.size10,
                        ),
                        child: Text(
                          translator.text("ward"),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: Dimens.size14,
                          ),
                        ),
                      ),
                      Text(
                        garden.wardName, //gardenAddress
                        style: TextStyle(
                          fontSize: Dimens.size16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.size5,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: Dimens.size10,
                        ),
                        child: Text(
                          translator.text("district"),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: Dimens.size14,
                          ),
                        ),
                      ),
                      Text(
                        garden.districtName, //gardenAddress
                        style: TextStyle(
                          fontSize: Dimens.size16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.size5,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: Dimens.size10,
                        ),
                        child: Text(
                          translator.text("city"),
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: Dimens.size14,
                          ),
                        ),
                      ),
                      Text(
                        garden.cityName, //gardenAddress
                        style: TextStyle(
                          fontSize: Dimens.size16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider<VisitingBloc>(
                                create: (blocContext) => VisitingBloc(
                                  repo: visitingRepo,
                                ),
                              ),
                              BlocProvider<NotificationBloc>(
                                create: (blocContext) => NotificationBloc(
                                  repo: notificationRepo,
                                ),
                              ),
                            ],
                            child: GardenBookingDialog(
                              username: user.username,
                              gardenID: garden.id,
                              farmerUsername: garden.username,
                              customerFullname: customerFullname,
                              gardenName: garden.gardenName,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        translator.text(
                          "visit_garden_booking",
                        ),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _returnUnreadNotiNumber(List<CustomerNotification> notifications) {
    int unread = 0;
    for (var noti in notifications) {
      if (noti.isSeen == false) {
        unread++;
      }
    }
    return unread;
  }
}
