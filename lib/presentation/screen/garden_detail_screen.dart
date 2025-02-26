import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/contract/contract_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_event.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_event.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_state.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_event.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/model/garden/garden.dart';
import 'package:mft_customer_side/model/tree/tree.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/widget/gardern_detail/tree_detail_dialog.dart';

class GardenDetailScreen extends StatefulWidget {
  final User user;
  final Garden garden;

  GardenDetailScreen({@required this.user, @required this.garden});

  @override
  _GardenDetailScreenState createState() =>
      _GardenDetailScreenState(user: user, garden: garden);
}

class _GardenDetailScreenState extends BaseState<GardenDetailScreen> {
  final User user;
  final Garden garden;

  _GardenDetailScreenState({@required this.user, @required this.garden});

  static final ContractRepo contractRepo = ContractRepo(
    apiClient: ContractAPI(
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

  final moneyFormat = NumberFormat.currency(locale: "vi", symbol: "");

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
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.size30,
                    ),
                    child: Text(
                      garden.gardenName,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: Dimens.size20,
                      ),
                    ),
                  ),
                  Text(
                    garden.plantTypeName, //plantTypeName
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
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
                                color: Colors.white60),
                          ),
                        ),
                        Text(
                          garden.fullname, //ownerName
                          style: TextStyle(
                            fontSize: Dimens.size16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
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
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            garden.address, //gardenAddress
                            style: TextStyle(
                              fontSize: Dimens.size16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                            translator.text("ward"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        Text(
                          garden.wardName, //gardenAddress
                          style: TextStyle(
                            fontSize: Dimens.size16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
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
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        Text(
                          garden.districtName, //gardenAddress
                          style: TextStyle(
                            fontSize: Dimens.size16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
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
                      bottom: Dimens.size10,
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
                              color: Colors.white60,
                            ),
                          ),
                        ),
                        Text(
                          garden.cityName, //gardenAddress
                          style: TextStyle(
                            fontSize: Dimens.size16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
            ),
            child: Text(
              translator.text("tree_list"),
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
                top: Dimens.size20,
                left: Dimens.size10,
                right: Dimens.size10,
              ),
              child: SingleChildScrollView(
                child: BlocBuilder<TreeBloc, TreeState>(
                  builder: (blocContext, state) {
                    if (state is TreeLoaded) {
                      return Column(
                        children: [
                          for (var tree in state.treeList.result)
                            _treeOverview(
                              tree: tree,
                              function: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<FarmerInfoBloc>(
                                        create: (blocContext) => FarmerInfoBloc(
                                          repo: contractRepo,
                                        )..add(
                                            GetFarmerInfo(
                                              treeID: tree.id,
                                            ),
                                          ),
                                      ),
                                      BlocProvider<ContractBloc>(
                                        create: (blocContext) => ContractBloc(
                                          repo: contractRepo,
                                        ),
                                      ),
                                      BlocProvider<NotificationBloc>(
                                        create: (blocContext) =>
                                            NotificationBloc(
                                          repo: notificationRepo,
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
                                    ],
                                    child: TreeDetailDialog(
                                      user: user,
                                      tree: tree,
                                    ),
                                  ),
                                ).then((value) {
                                  BlocProvider.of<TreeBloc>(context).add(
                                    GetAllTree(
                                      gardenID: garden.id,
                                    ),
                                  );
                                });
                              },
                            ),
                        ],
                      );
                    }

                    if (state is TreeEmpty) {
                      return Center(
                        child: Text(
                          translator.text("no_tree"),
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

  Widget _treeOverview({Tree tree, Function function}) {
    return GestureDetector(
      onTap: function,
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
                      right: Dimens.size30,
                    ),
                    child: tree.image == null
                        ? Image.asset(
                            'assets/images/empty_pic.png',
                          )
                        : Image.network(
                            tree.image), //add img later //null checking
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimens.size10,
                            ),
                            child: Text(
                              translator.text("tree_code"),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: Dimens.size14,
                              ),
                            ),
                          ),
                          Text(
                            tree.treeCode, //treeCode
                            style: TextStyle(
                              fontSize: Dimens.size16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimens.size10,
                            ),
                            child: Text(
                              translator.text("tree_price"),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: Dimens.size14,
                              ),
                            ),
                          ),
                          Text(
                            "${moneyFormat.format(tree.price)} VND", //treePrice
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                              fontSize: Dimens.size18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimens.size10,
                            ),
                            child: Text(
                              translator.text("standard"),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: Dimens.size14,
                              ),
                            ),
                          ),
                          Text(
                            tree.standard == null
                                ? ""
                                : tree.standard, //treeStandard
                            style: TextStyle(
                              fontSize: Dimens.size16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: Dimens.size10,
                          ),
                          child: Text(
                            translator.text("description"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: Dimens.size10,
                          ),
                          child: Text(
                            tree.description == null
                                ? ""
                                : tree.description, //treeDesc
                            style: TextStyle(
                              fontSize: Dimens.size16,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
