import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/block/block_api.dart';
import 'package:mft_customer_side/logic/api/contract/contract_api.dart';
import 'package:mft_customer_side/logic/api/exchange/exchange_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/package/pakage_api.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/bloc/block/block_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_rate/contract_rate_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_rate/contract_rate_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_event.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_bloc.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_bloc.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_state.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_event.dart';
import 'package:mft_customer_side/logic/repo/block/block_repo.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/package/package_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/model/exchange/exchange_request.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/exchange_management_screen.dart';
import 'package:mft_customer_side/presentation/screen/response_screen.dart';
import 'package:mft_customer_side/presentation/widget/exchange/view_requester_info_dialog.dart';
import 'package:mft_customer_side/presentation/widget/exchange/view_tree_dialog.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ExchangeScreen extends StatefulWidget {
  final User user;

  ExchangeScreen({@required this.user});

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState(user: user);
}

class _ExchangeScreenState extends BaseState<ExchangeScreen> {
  final User user;

  _ExchangeScreenState({@required this.user});

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

  static final PackageRepo packageRepo = PackageRepo(
    apiClient: PackageAPI(
      httpClient: http.Client(),
    ),
  );

  static final UserRepo userRepo = UserRepo(
    apiClient: UserAPI(
      httpClient: http.Client(),
    ),
  );

  static final BlockRepo blockRepo = BlockRepo(
    apiClient: BlockAPI(
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
                          right: Dimens.size5,
                        ),
                        child: GestureDetector(
                          onTap: _selectedValue == null
                              ? () {}
                              : () {
                                  BlocProvider.of<RequestBloc>(context).add(
                                    GetRequestByPlantType(
                                      username: user.username,
                                      plantTypeName: _selectedValue,
                                    ),
                                  );
                                },
                          child: Icon(
                            Icons.search,
                            size: Dimens.size30,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: Dimens.size10,
                        ),
                        child: GestureDetector(
                          onTap: () {
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
                            ).then(
                              (value) {
                                if (_isEnable == true) {
                                  BlocProvider.of<RequestBloc>(context).add(
                                    GetAllActiveRequestByInterest(
                                        username: user.username),
                                  );
                                } else if (_selectedValue != null) {
                                  BlocProvider.of<RequestBloc>(context).add(
                                    GetRequestByPlantType(
                                      username: user.username,
                                      plantTypeName: _selectedValue,
                                    ),
                                  );
                                } else {
                                  BlocProvider.of<RequestBloc>(context).add(
                                    GetAllActiveRequest(
                                      username: user.username,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          child: Icon(
                            Icons.edit,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translator.text("exchange_list"),
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
                          //call get all active request by interest
                          BlocProvider.of<RequestBloc>(context).add(
                            GetAllActiveRequestByInterest(
                                username: user.username),
                          );
                        } else {
                          BlocProvider.of<RequestBloc>(context).add(
                            GetAllActiveRequest(username: user.username),
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
                    left: Dimens.size10,
                    right: Dimens.size10,
                    top: Dimens.size20,
                  ),
                  child: SingleChildScrollView(
                    child: BlocBuilder<RequestBloc, RequestState>(
                      builder: (blocContext, state) {
                        if (state is AllActiveRequestLoaded) {
                          return Column(
                            children: [
                              for (var request in state.requestList.result)
                                _requestOverview(request),
                            ],
                          );
                        }

                        if (state is AllActiveRequestByInterestLoaded) {
                          return Column(
                            children: [
                              for (var request in state.requestList.result)
                                _requestOverview(request),
                            ],
                          );
                        }

                        if (state is AllRequestByPlantType) {
                          return Column(
                            children: [
                              for (var request in state.requestList.result)
                                _requestOverview(request),
                            ],
                          );
                        }

                        if (state is RequestListEmpty) {
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
          Padding(
            padding: const EdgeInsets.only(
              left: Dimens.size20,
              right: Dimens.size90,
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
      onClear: () {
        BlocProvider.of<RequestBloc>(context).add(
          GetAllActiveRequest(username: user.username),
        );
      },
      dialogBox: false,
      isExpanded: true,
      menuConstraints: BoxConstraints.tight(Size.fromHeight(300)),
    );
  }

  Widget _requestOverview(ExchangeRequest request) {
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
                Container(
                  height: Dimens.treeImage,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size20,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      backgroundImage: request.avatar != null
                          ? NetworkImage(request.avatar)
                          : null,
                      child: request.avatar == null
                          ? Icon(
                              Icons.person,
                              size: Dimens.size50,
                            )
                          : Container(),
                      radius: Dimens.size35,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider<UserInfoBloc>(
                                  create: (blocContext) =>
                                      UserInfoBloc(repo: userRepo)
                                        ..add(
                                          GetUserInfo(
                                            username: request.username,
                                          ),
                                        ),
                                ),
                                BlocProvider<BlockBloc>(
                                  create: (blocContext) => BlockBloc(
                                    repo: blockRepo,
                                  ),
                                ),
                              ],
                              child: RequesterInfoDialog(
                                username: user.username,
                              ),
                            ),
                          ).then(
                            (value) {
                              if (_isEnable == true) {
                                BlocProvider.of<RequestBloc>(context).add(
                                  GetAllActiveRequestByInterest(
                                      username: user.username),
                                );
                              } else if (_selectedValue != null) {
                                BlocProvider.of<RequestBloc>(context).add(
                                  GetRequestByPlantType(
                                    username: user.username,
                                    plantTypeName: _selectedValue,
                                  ),
                                );
                              } else {
                                BlocProvider.of<RequestBloc>(context).add(
                                  GetAllActiveRequest(
                                    username: user.username,
                                  ),
                                );
                              }
                            },
                          );
                        },
                        child: Text(
                          request.fullname, //treeCode
                          style: TextStyle(
                            fontSize: Dimens.size18,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
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
                    ],
                  ),
                ),
                Column(
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
                                BlocProvider(
                                  create: (blocContext) => RequestBloc(
                                    repo: exchangeRepo,
                                  )..add(
                                      GetTreeInfoByRequest(
                                        requestID: request.id,
                                      ),
                                    ),
                                ),
                              ],
                              child: ViewTreeDialog(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          translator.text("view_tree"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimens.size5,
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
                                          requestID: request.id,
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
                                    ),
                                  ),
                                  BlocProvider<NotificationBloc>(
                                    create: (blocContext) => NotificationBloc(
                                      repo: notificationRepo,
                                    ),
                                  ),
                                ],
                                child: ResponseScreen(
                                  plantTypeName: request.plantTypeName,
                                  exchangeYield: request.weight,
                                  exchangeRequestID: request.id,
                                  username: user.username,
                                  requestUsername: request.username,
                                ),
                              ),
                            ),
                          ).then(
                            (value) {
                              if (_isEnable == true) {
                                BlocProvider.of<RequestBloc>(context).add(
                                  GetAllActiveRequestByInterest(
                                      username: user.username),
                                );
                              } else if (_selectedValue != null) {
                                BlocProvider.of<RequestBloc>(context).add(
                                  GetRequestByPlantType(
                                    username: user.username,
                                    plantTypeName: _selectedValue,
                                  ),
                                );
                              } else {
                                BlocProvider.of<RequestBloc>(context).add(
                                  GetAllActiveRequest(
                                    username: user.username,
                                  ),
                                );
                              }
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange.shade600,
                        ),
                        child: Text(
                          translator.text("exchange"),
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
