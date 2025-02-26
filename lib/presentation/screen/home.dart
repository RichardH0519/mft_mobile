import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mft_customer_side/common/icons/mft_icons.dart';
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/contract/contract_api.dart';
import 'package:mft_customer_side/logic/api/exchange/exchange_api.dart';
import 'package:mft_customer_side/logic/api/garden/garden_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/plant_type/plant_type_api.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_event.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_bloc.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_event.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_bloc.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_event.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';
import 'package:mft_customer_side/logic/repo/garden/garden_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/plant_type/plant_type_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/exchange_screen.dart';
import 'package:mft_customer_side/presentation/screen/home_screen.dart';
import 'package:mft_customer_side/presentation/screen/profile_screen.dart';
import 'package:mft_customer_side/presentation/screen/rented_tree_screen.dart';

class Home extends StatelessWidget {
  final User user;

  Home({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Device.get().isPhone
        ? Phone(
            user: user,
          )
        : Container();
  }
}

class Phone extends StatefulWidget {
  final User user;

  Phone({@required this.user});

  @override
  _PhoneState createState() => _PhoneState(
        user: user,
      );
}

class _PhoneState extends BaseState<Phone> {
  static final GardenRepo gardenRepo = GardenRepo(
    apiClient: GardenAPI(
      httpClient: http.Client(),
    ),
  );

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

  static final PlantTypeRepo plantTypeRepo = PlantTypeRepo(
    apiClient: PlantTypeAPI(
      httpClient: http.Client(),
    ),
  );

  static final UserRepo userRepo = UserRepo(
    apiClient: UserAPI(
      httpClient: http.Client(),
    ),
  );

  static final NotificationRepo notificationRepo = NotificationRepo(
    apiClient: NotificationAPI(),
  );

  final User user;

  _PhoneState({@required this.user});

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime _currentBackPressTime;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      MultiBlocProvider(
        providers: [
          BlocProvider<GardenBloc>(
            create: (blocContext) => GardenBloc(
              repo: gardenRepo,
            )..add(
                GetAllGarden(),
              ),
          ),
          BlocProvider<UserInfoBloc>(
            create: (blocContext) => UserInfoBloc(
              repo: userRepo,
            )..add(
                GetUserInfo(
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
        child: HomeScreen(
          user: user,
        ),
      ),
      //home screen

      MultiBlocProvider(
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

      MultiBlocProvider(
        providers: [
          BlocProvider<RequestBloc>(
            create: (blocContext) => RequestBloc(
              repo: exchangeRepo,
            )..add(
                GetAllActiveRequest(
                  username: user.username,
                ),
              ),
          ),
          BlocProvider<PlantTypeBloc>(
            create: (blocContext) => PlantTypeBloc(
              repo: plantTypeRepo,
            )..add(
                GetPlantType(),
              ),
          ),
        ],
        child: ExchangeScreen(
          user: user,
        ),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider<UserInfoBloc>(
            create: (blocContext) => UserInfoBloc(
              repo: userRepo,
            )..add(
                GetUserInfo(
                  username: user.username,
                ),
              ),
          ),
        ],
        child: ProfileScreen(
          user: user,
        ),
      ), //profile screen
    ];
    return WillPopScope(
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
      onWillPop: _onWillPop,
    );
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: translator.text("double_pressed_back_button"),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: Dimens.thick05,
            color: CustomColors.lineNavigationBottom,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: Dimens.size30),
            label: translator.text("home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(MFTIcons.tree_2, size: Dimens.size30),
            label: translator.text("rented_tree"),
          ),
          BottomNavigationBarItem(
            icon: Icon(MFTIcons.hands_helping, size: Dimens.size30),
            label: translator.text("exchange"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: Dimens.size30),
            label: translator.text("profile"),
          ),
        ],
        unselectedFontSize: Dimens.size12,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: Theme.of(context).cardTheme.elevation,
        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        unselectedLabelStyle:
            TextStyle(color: Theme.of(context).textTheme.bodyText2.color),
        unselectedItemColor: Theme.of(context).textTheme.bodyText2.color,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
