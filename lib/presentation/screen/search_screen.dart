import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/tree/tree_api.dart';
import 'package:mft_customer_side/logic/api/visiting/visiting_api.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_bloc.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_event.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_bloc.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_state.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_event.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_bloc.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/tree/tree_repo.dart';
import 'package:mft_customer_side/logic/repo/visiting/visiting_repo.dart';
import 'package:mft_customer_side/model/garden/garden.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/garden_detail_screen.dart';
import 'package:mft_customer_side/presentation/screen/response_screen.dart';
import 'package:mft_customer_side/presentation/widget/home/garden_booking_dialog.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchScreen extends StatefulWidget {
  final User user;
  final String customerFullname;

  SearchScreen({
    @required this.user,
    @required this.customerFullname,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState(
        user: user,
        customerFullname: customerFullname,
      );
}

class _SearchScreenState extends BaseState<SearchScreen> {
  final User user;
  final String customerFullname;

  _SearchScreenState({
    @required this.user,
    @required this.customerFullname,
  });

  static final TreeRepo treeRepo = TreeRepo(
    apiClient: TreeAPI(
      httpClient: http.Client(),
    ),
  );

  static final VisitingRepo visitingRepo = VisitingRepo(
    apiClient: VisitingAPI(
      httpClient: http.Client(),
    ),
  );

  static final NotificationRepo notificationRepo = NotificationRepo(
    apiClient: NotificationAPI(),
  );

  bool _isEnable = false;

  List<DropdownMenuItem> _items = [];

  var _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: Stack(
        children: [
          Column(
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
                    top: Dimens.size45,
                    bottom: Dimens.size15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: Dimens.size20,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<GardenBloc>(context).add(
                              GetAllGardenByPlantType(
                                  plantTypeName: _selectedValue),
                            );
                          },
                          child: Icon(
                            Icons.search,
                            size: Dimens.size30,
                            color: Colors.white60,
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
                child: Text(
                  translator.text("search_result"),
                  style: TextStyle(
                    fontSize: Dimens.size18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimens.size10,
                    right: Dimens.size10,
                    top: Dimens.size20,
                  ),
                  child: SingleChildScrollView(
                    child: BlocBuilder<GardenBloc, GardenState>(
                      builder: (blocContext, state) {
                        if (state is GardenByPlantTypeLoaded) {
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
                          child: Text(
                            translator.text("your_search_result"),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimens.size30,
              right: Dimens.size70,
              top: Dimens.size30,
            ),
            child: BlocBuilder<PlantTypeBloc, PlantTypeState>(
              builder: (blocContext, state) {
                if (state is PlantTypeLoaded) {
                  _items = [];
                  for (var plantType in state.plantTypeList.result) {
                    _items.add(
                      DropdownMenuItem(
                        child: Text(plantType.plantTypeName),
                        value: plantType.plantTypeName,
                      ),
                    );
                  }

                  return _searchBar();
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return SearchableDropdown.single(
      items: _items,
      value: _selectedValue,
      hint: translator.text("search_hint"),
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w700,
        fontSize: Dimens.size20,
        color: Colors.white,
      ),
      iconEnabledColor: Colors.white,
      iconDisabledColor: Colors.white,
      searchHint: null,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
      dialogBox: false,
      isExpanded: true,
      menuConstraints: BoxConstraints.tight(Size.fromHeight(300)),
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
}
