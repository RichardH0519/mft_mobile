import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/contract/contract_api.dart';
import 'package:mft_customer_side/logic/api/contract_detail/contract_detail_api.dart';
import 'package:mft_customer_side/logic/api/feedback/feedback_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/tree_process/tree_process_api.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_state.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_state.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract-detail_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract_detail_event.dart';
import 'package:mft_customer_side/logic/bloc/feedback/feedback_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_process/tree_process_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_process/tree_process_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_state.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';
import 'package:mft_customer_side/logic/repo/contract_detail/contract_detail_repo.dart';
import 'package:mft_customer_side/logic/repo/feedback/feedback_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/tree_process/tree_process_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/model/tree/tree_contract_info.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/contract_screen_active.dart';
import 'package:mft_customer_side/presentation/screen/crops_detail_screen.dart';
import 'package:mft_customer_side/presentation/screen/tree_process_screen.dart';
import 'package:mft_customer_side/presentation/widget/tree_detail/feedback_dialog.dart';

class TreeDetailScreen extends StatefulWidget {
  final String username;
  final int treeID;
  final int contractID;
  final int status;
  final int contractNumber;

  TreeDetailScreen({
    @required this.username,
    @required this.treeID,
    @required this.contractID,
    @required this.status,
    @required this.contractNumber,
  });

  @override
  _TreeDetailScreenState createState() => _TreeDetailScreenState(
        username: username,
        treeID: treeID,
        contractID: contractID,
        status: status,
        contractNumber: contractNumber,
      );
}

class _TreeDetailScreenState extends BaseState<TreeDetailScreen> {
  final String username;
  final int treeID;
  final int contractID;
  final int status;
  final int contractNumber;

  _TreeDetailScreenState({
    @required this.username,
    @required this.treeID,
    @required this.contractID,
    @required this.status,
    @required this.contractNumber,
  });

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

  static final TreeProcessRepo treeProcessRepo = TreeProcessRepo(
    apiClient: TreeProcessAPI(
      httpClient: http.Client(),
    ),
  );

  static final ContractDetailRepo contractDetailRepo = ContractDetailRepo(
    apiClient: ContractDetailAPI(
      httpClient: http.Client(),
    ),
  );

  static final FeedbackRepo feedbackRepo = FeedbackRepo(
    apiClient: FeedbackAPI(
      httpClient: http.Client(),
    ),
  );

  int gardenID;
  final moneyFormat = NumberFormat.currency(locale: "vi", symbol: "");
  String farmerUsername;
  var gardenName;
  var customerFullname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<TreeInfoBloc, TreeInfoState>(
              builder: (builderContext, state) {
                if (state is TreeInfoLoaded) {
                  gardenName = state.tree.gardenName;

                  return Container(
                    width: double.infinity,
                    height: Dimens.treeDetailScreenImage,
                    child: state.tree.image == null
                        ? Image.asset(
                            'assets/images/empty_pic.png',
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            state.tree.image,
                            fit: BoxFit.fill,
                          ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: Dimens.size15,
                top: Dimens.size20,
              ),
              child: Text(
                translator.text("tree_detail"),
                style: TextStyle(
                  fontSize: Dimens.size20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            BlocBuilder<TreeInfoBloc, TreeInfoState>(
              builder: (builderContext, state) {
                if (state is TreeInfoLoaded) {
                  gardenID = state.tree.gardenID;

                  return _treeDetail(state.tree);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: Dimens.size15,
                right: Dimens.size15,
                top: Dimens.size20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translator.text("farmer_detail"),
                    style: TextStyle(
                      fontSize: Dimens.size20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider<FeedbackBloc>(
                              create: (blocContext) => FeedbackBloc(
                                repo: feedbackRepo,
                              ),
                            ),
                          ],
                          child: FeedbackDialog(
                            customerUsername: username,
                            farmerUsername: farmerUsername,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.feedback,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<FarmerInfoBloc, FarmerInfoState>(
              builder: (builderContext, state) {
                if (state is FarmerInfoLoaded) {
                  farmerUsername = state.user.username;

                  return _farmerDetail(state.user);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.size20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  status == 1
                      ? Padding(
                          padding: const EdgeInsets.only(
                            right: Dimens.size5,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (routeContext) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<FarmerInfoBloc>(
                                        create: (blocContext) =>
                                            FarmerInfoBloc(repo: contractRepo)
                                              ..add(
                                                GetFarmerInfo(
                                                  treeID: treeID,
                                                ),
                                              ),
                                      ),
                                      BlocProvider<UserInfoBloc>(
                                        create: (blocContext) =>
                                            UserInfoBloc(repo: userRepo)
                                              ..add(
                                                GetUserInfo(
                                                  username: username,
                                                ),
                                              ),
                                      ),
                                      BlocProvider<TreeInfoBloc>(
                                        create: (blocContext) =>
                                            TreeInfoBloc(repo: contractRepo)
                                              ..add(
                                                GetTreeInfo(
                                                  treeID: treeID,
                                                ),
                                              ),
                                      ),
                                      BlocProvider<ContractBloc>(
                                        create: (blocContext) =>
                                            ContractBloc(repo: contractRepo)
                                              ..add(
                                                GetContractByTreeID(
                                                  treeID: treeID,
                                                ),
                                              ),
                                      ),
                                    ],
                                    child: ContractScreenActive(),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              translator.text("contract_detail"),
                              style: TextStyle(
                                fontSize: Dimens.size12,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange.shade600,
                            ),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.size5,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (routeContext) => MultiBlocProvider(
                              providers: [
                                BlocProvider<ContractDetailBloc>(
                                  create: (blocContext) => ContractDetailBloc(
                                    repo: contractDetailRepo,
                                  )..add(
                                      GetContractDetails(
                                        contractID: contractID,
                                      ),
                                    ),
                                ),
                              ],
                              child: CropsDetailScreen(
                                farmerUsername: farmerUsername,
                                contractNumber: contractNumber,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        translator.text("crops"),
                        style: TextStyle(
                          fontSize: Dimens.size12,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                    ),
                  ),
                  status == 1
                      ? BlocBuilder<UserInfoBloc, UserInfoState>(
                          builder: (context, state) {
                            if (state is UserInfoLoaded) {
                              customerFullname = state.user.fullname;
                            }

                            return Padding(
                              padding: const EdgeInsets.only(
                                left: Dimens.size5,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (routeContext) =>
                                          MultiBlocProvider(
                                        providers: [
                                          BlocProvider<TreeProcessBloc>(
                                            create: (blocContext) =>
                                                TreeProcessBloc(
                                              repo: treeProcessRepo,
                                            )..add(
                                                    GetTreeProcess(
                                                      contractID: contractID,
                                                    ),
                                                  ),
                                          ),
                                        ],
                                        child: TreeProcessScreen(
                                          contractID: contractID,
                                          gardenID: gardenID,
                                          username: username,
                                          farmerUsername: farmerUsername,
                                          customerFullname: customerFullname,
                                          gardenName: gardenName,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  translator.text("tree_growth"),
                                  style: TextStyle(
                                    fontSize: Dimens.size12,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _treeDetail(TreeContractInfo tree) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimens.size10,
        left: Dimens.size15,
        right: Dimens.size15,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: Dimens.thick02,
          ),
          borderRadius: BorderRadius.circular(
            Dimens.size10,
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            Dimens.size10,
          ),
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
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                        fontSize: Dimens.size18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    tree.treeCode, //treeCode
                    style: TextStyle(
                      fontSize: Dimens.size20,
                    ),
                  ),
                ],
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
                        translator.text("tree_price"),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      "${moneyFormat.format(tree.treePrice)} VND", //treePrice
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                        translator.text("standard"),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      tree.standard == null ? "" : tree.standard, //treeStandard
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                        translator.text("crop"),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      tree.crops == null
                          ? ""
                          : tree.crops.toString(), //treeStandard
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                        translator.text("yield"),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      tree.yield == null
                          ? ""
                          : tree.yield.toString() + " kg", //treeStandard
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                        translator.text("garden_name"),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        tree.gardenName,
                        style: TextStyle(
                          fontSize: Dimens.size20,
                        ),
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
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      tree.address,
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      tree.wardName, //gardenAddress
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      tree.districtName, //gardenAddress
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      tree.cityName, //gardenAddress
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                child: Text(
                  translator.text("description"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size18,
                    fontStyle: FontStyle.italic,
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
                    tree.description == null ? "" : tree.description, //treeDesc
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
      ),
    );
  }

  Widget _farmerDetail(User user) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimens.size10,
        left: Dimens.size15,
        right: Dimens.size15,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: Dimens.thick02,
          ),
          borderRadius: BorderRadius.circular(
            Dimens.size10,
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            Dimens.size10,
          ),
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
                      translator.text("fullname"),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                        fontSize: Dimens.size18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    user.fullname, //treeCode
                    style: TextStyle(
                      fontSize: Dimens.size20,
                    ),
                  ),
                ],
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
                        translator.text("phone"),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      user.phone, //treePrice
                      style: TextStyle(
                        fontSize: Dimens.size20,
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
                        translator.text("email"),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        user.email == null ? "" : user.email, //treeStandard
                        style: TextStyle(
                          fontSize: Dimens.size20,
                        ),
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
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          fontSize: Dimens.size18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${user.address}, ${user.wardName}, ${user.districtName}, ${user.cityName}",
                        style: TextStyle(
                          fontSize: Dimens.size20,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
