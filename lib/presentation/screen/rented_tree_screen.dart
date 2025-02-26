import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/contract/contract_api.dart';
import 'package:mft_customer_side/logic/api/exchange/exchange_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/package/pakage_api.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_state.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/package/package_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_event.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/package/package_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/model/contract/contract_cancel_info.dart';
import 'package:mft_customer_side/model/contract/contract_overview.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/contract_screen.dart';
import 'package:mft_customer_side/presentation/screen/tree_detail_screen.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';
import 'package:mft_customer_side/presentation/widget/rented_tree/cancel_info_dialog.dart';
import 'package:mft_customer_side/presentation/widget/rented_tree/exchange_dialog.dart';

class RentedTreeScreen extends StatefulWidget {
  final User user;

  RentedTreeScreen({@required this.user});

  @override
  _RentedTreeScreenState createState() => _RentedTreeScreenState(user: user);
}

class _RentedTreeScreenState extends BaseState<RentedTreeScreen> {
  final User user;

  _RentedTreeScreenState({@required this.user});

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

  static final NotificationRepo notificationRepo = NotificationRepo(
    apiClient: NotificationAPI(),
  );

  var deletedContractNumber;
  var deletedFarmerUsername;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractBloc, ContractState>(
      listener: (context, state) {
        if (state is ContractDeleteSuccess) {
          BlocProvider.of<NotificationBloc>(context).add(
            DeleteContractNotification(
              farmerUsername: deletedFarmerUsername,
              contractNumber: deletedContractNumber,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.whiteSmoke,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: Dimens.size35,
                left: Dimens.size15,
              ),
              child: Text(
                translator.text("rented_tree_list"),
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
                  child: BlocBuilder<ContractBloc, ContractState>(
                    builder: (builderContext, state) {
                      if (state is ContractOverviewsLoaded) {
                        return Column(
                          children: [
                            for (var contract
                                in state.contractOverviewList.result.reversed)
                              _contractOverview(contract),
                          ],
                        );
                      }

                      if (state is ContractOverviewsEmpty) {
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
      ),
    );
  }

  Widget _contractOverview(ContractOverview contract) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                            translator.text("contract_number"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                            ),
                          ),
                        ),
                        Text(
                          contract.contractNumber.toString(), //treeCode
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
                            translator.text("tree_code"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                            ),
                          ),
                        ),
                        Text(
                          contract.treeCode, //treeCode
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
                            translator.text("plant_type"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            contract.plantTypeName, //treeCode
                            style: TextStyle(
                              fontSize: Dimens.size16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
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
                            translator.text("garden_name"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            contract.gardenName, //gardenname
                            style: TextStyle(
                              fontSize: Dimens.size16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
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
                            translator.text("owner"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            contract.fullname, //owner
                            style: TextStyle(
                              fontSize: Dimens.size16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
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
                            translator.text("contract_status"),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Dimens.size14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _returnTextByStatus(contract.status),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.size5,
                ),
                child: _returnButtonColumnByStatus(contract),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _returnTextByStatus(int status) {
    switch (status) {
      case 0:
        return Text(
          translator.text("pending"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.orange,
          ),
        );
        break;
      case 1:
        return Text(
          translator.text("active"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.green,
          ),
        );
        break;
      case 2:
        return Text(
          translator.text("cancel"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
        );
        break;
      case 3:
        return Text(
          translator.text("waiting"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
          ),
        );
        break;

      case 4:
        return Text(
          translator.text("waiting"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.deepOrange,
          ),
        );
        break;

      case 5:
        return Text(
          translator.text("done"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.brown,
          ),
        );
        break;
    }
  }

  Widget _returnButtonColumnByStatus(ContractOverview contract) {
    switch (contract.status) {
      case 0:
        return Column(
          children: [
            ElevatedButton(
              onPressed: _returnFunctionByStatus(
                contract.status,
                contract.id,
                user.username,
                contract.contractID,
                contract.contractNumber,
                contract.username,
              ),
              child: Text(
                translator.text("cancel_request"),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        );

        break;

      case 1:
        return Column(
          children: [
            ElevatedButton(
              onPressed: _returnFunctionByStatus(
                contract.status,
                contract.id,
                user.username,
                contract.contractID,
                contract.contractNumber,
                contract.username,
              ),
              child: Text(
                translator.text("view_tree"),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<PackageBloc>(
                        create: (blocContext) => PackageBloc(repo: packageRepo)
                          ..add(
                            GetYield(
                              username: user.username,
                              contractID: contract.contractID,
                            ),
                          ),
                      ),
                      BlocProvider<RequestBloc>(
                        create: (blocContext) => RequestBloc(
                          repo: exchangeRepo,
                        ),
                      ),
                    ],
                    child: ExchangeDialog(
                      contractID: contract.contractID,
                      plantTypeID: contract.plantTypeID,
                      username: user.username,
                    ),
                  ),
                );
              },
              child: Text(
                translator.text("exchange"),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange.shade600,
              ),
            ),
          ],
        );
        break;

      case 2:
        return Column(
          children: [
            ElevatedButton(
              onPressed: _returnFunctionByStatus(
                contract.status,
                contract.id,
                user.username,
                contract.contractID,
                contract.contractNumber,
                contract.username,
              ),
              child: Text(
                translator.text("detail"),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
          ],
        );
        break;

      case 3:
        return Column(
          children: [
            ElevatedButton(
              onPressed: _returnFunctionByStatus(
                contract.status,
                contract.id,
                user.username,
                contract.contractID,
                contract.contractNumber,
                contract.username,
              ),
              child: Text(
                translator.text("confirm_contract"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                deletedContractNumber = contract.contractNumber;
                deletedFarmerUsername = contract.username;

                BlocProvider.of<ContractBloc>(context).add(
                  DeleteContractRequest(
                    contractID: contract.contractID,
                  ),
                );

                BlocProvider.of<ContractBloc>(context).add(
                  GetContractOverviews(
                    username: user.username,
                  ),
                );
              },
              child: Text(
                translator.text("cancel_request"),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        );
        break;

      case 4:
        return contract.cancelParty != user.username
            ? Column(
                children: [
                  ElevatedButton(
                    onPressed: _returnFunctionByStatus(
                      contract.status,
                      contract.id,
                      user.username,
                      contract.contractID,
                      contract.contractNumber,
                      contract.username,
                    ),
                    child: Text(
                      translator.text("detail"),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )
            : Container();
        break;

      case 5:
        return Column(
          children: [
            ElevatedButton(
              onPressed: _returnFunctionByStatus(
                contract.status,
                contract.id,
                user.username,
                contract.contractID,
                contract.contractNumber,
                contract.username,
              ),
              child: Text(
                translator.text("view_tree"),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ContractBloc>(
                        create: (blocContext) => ContractBloc(
                          repo: contractRepo,
                        )..add(
                            GetContractCancelInfo(
                              contractID: contract.contractID,
                            ),
                          ),
                      ),
                    ],
                    child: CancelInfoDialog(
                      status: contract.status,
                      username: user.username,
                      contractID: contract.contractID,
                      farmerUsername: deletedFarmerUsername,
                      contractNumber: deletedContractNumber,
                    ),
                  ),
                );
              },
              child: Text(
                translator.text("detail"),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
          ],
        );
        break;
    }
  }

  Function _returnFunctionByStatus(
    int status,
    int treeID,
    String username,
    int contractID,
    int contractNumber,
    String farmerUsername,
  ) {
    switch (status) {
      case 0:
        return () {
          deletedContractNumber = contractNumber;
          deletedFarmerUsername = farmerUsername;

          BlocProvider.of<ContractBloc>(context).add(
            DeleteContractRequest(
              contractID: contractID,
            ),
          );

          BlocProvider.of<ContractBloc>(context).add(
            GetContractOverviews(
              username: username,
            ),
          );
        };
        break;

      case 1:
        return () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (routeContext) => MultiBlocProvider(
                providers: [
                  BlocProvider<TreeInfoBloc>(
                    create: (blocContext) => TreeInfoBloc(repo: contractRepo)
                      ..add(
                        GetTreeInfo(
                          treeID: treeID,
                        ),
                      ),
                  ),
                  BlocProvider<FarmerInfoBloc>(
                    create: (blocContext) => FarmerInfoBloc(repo: contractRepo)
                      ..add(
                        GetFarmerInfo(
                          treeID: treeID,
                        ),
                      ),
                  ),
                  BlocProvider<UserInfoBloc>(
                    create: (blocContext) => UserInfoBloc(repo: userRepo)
                      ..add(
                        GetUserInfo(
                          username: username,
                        ),
                      ),
                  ),
                ],
                child: TreeDetailScreen(
                  username: username,
                  treeID: treeID,
                  contractID: contractID,
                  status: status,
                  contractNumber: contractNumber,
                ),
              ),
            ),
          );
        };
        break;

      case 2:
        return () {
          showDialog(
            context: context,
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<ContractBloc>(
                  create: (blocContext) => ContractBloc(
                    repo: contractRepo,
                  )..add(
                      GetContractCancelInfo(
                        contractID: contractID,
                      ),
                    ),
                ),
              ],
              child: CancelInfoDialog(
                status: status,
                username: username,
                contractID: contractID,
                farmerUsername: farmerUsername,
                contractNumber: contractNumber,
              ),
            ),
          );
        };
        break;

      case 3:
        return () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (routeContext) => MultiBlocProvider(
                providers: [
                  BlocProvider<FarmerInfoBloc>(
                    create: (blocContext) => FarmerInfoBloc(repo: contractRepo)
                      ..add(
                        GetFarmerInfo(
                          treeID: treeID,
                        ),
                      ),
                  ),
                  BlocProvider<UserInfoBloc>(
                    create: (blocContext) => UserInfoBloc(repo: userRepo)
                      ..add(
                        GetUserInfo(
                          username: username,
                        ),
                      ),
                  ),
                  BlocProvider<TreeInfoBloc>(
                    create: (blocContext) => TreeInfoBloc(repo: contractRepo)
                      ..add(
                        GetTreeInfo(
                          treeID: treeID,
                        ),
                      ),
                  ),
                  BlocProvider<ContractBloc>(
                    create: (blocContext) => ContractBloc(repo: contractRepo)
                      ..add(
                        GetContractByTreeID(
                          treeID: treeID,
                        ),
                      ),
                  ),
                  BlocProvider<NotificationBloc>(
                    create: (blocContext) => NotificationBloc(
                      repo: notificationRepo,
                    ),
                  ),
                ],
                child: ContractScreen(),
              ),
            ),
          );
        };
        break;

      case 4:
        return () {
          showDialog(
            context: context,
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<ContractBloc>(
                  create: (blocContext) => ContractBloc(
                    repo: contractRepo,
                  )..add(
                      GetContractCancelInfo(
                        contractID: contractID,
                      ),
                    ),
                ),
                BlocProvider<NotificationBloc>(
                  create: (blocContext) => NotificationBloc(
                    repo: notificationRepo,
                  ),
                ),
              ],
              child: CancelInfoDialog(
                status: status,
                username: username,
                contractID: contractID,
                farmerUsername: farmerUsername,
                contractNumber: contractNumber,
              ),
            ),
          ).then((value) {
            BlocProvider.of<ContractBloc>(context).add(
              GetContractOverviews(
                username: username,
              ),
            );
          });
        };
        break;

      case 5:
        return () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (routeContext) => MultiBlocProvider(
                providers: [
                  BlocProvider<TreeInfoBloc>(
                    create: (blocContext) => TreeInfoBloc(repo: contractRepo)
                      ..add(
                        GetTreeInfo(
                          treeID: treeID,
                        ),
                      ),
                  ),
                  BlocProvider<FarmerInfoBloc>(
                    create: (blocContext) => FarmerInfoBloc(repo: contractRepo)
                      ..add(
                        GetFarmerInfo(
                          treeID: treeID,
                        ),
                      ),
                  ),
                  BlocProvider<UserInfoBloc>(
                    create: (blocContext) => UserInfoBloc(repo: userRepo)
                      ..add(
                        GetUserInfo(
                          username: username,
                        ),
                      ),
                  ),
                ],
                child: TreeDetailScreen(
                  username: username,
                  treeID: treeID,
                  contractID: contractID,
                  status: status,
                  contractNumber: contractNumber,
                ),
              ),
            ),
          );
        };
        break;
    }
  }
}
