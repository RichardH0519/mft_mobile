import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/contract_detail/contract_detail_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/api/visiting/visiting_api.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract-detail_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract_detail_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_process/tree_process_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_process/tree_process_state.dart';
import 'package:mft_customer_side/logic/bloc/visiting/visiting_bloc.dart';
import 'package:mft_customer_side/logic/repo/contract_detail/contract_detail_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/logic/repo/visiting/visiting_repo.dart';
import 'package:mft_customer_side/model/tree_process/tree_process.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/widget/home/garden_booking_dialog.dart';
import 'package:mft_customer_side/presentation/widget/tree_process/delivery_date_dialog.dart';

class TreeProcessScreen extends StatefulWidget {
  final int contractID;
  final int gardenID;
  final String username;
  final String farmerUsername;
  final String customerFullname;
  final String gardenName;

  TreeProcessScreen({
    @required this.contractID,
    @required this.gardenID,
    @required this.username,
    @required this.farmerUsername,
    @required this.customerFullname,
    @required this.gardenName,
  });

  @override
  _TreeProcessScreenState createState() => _TreeProcessScreenState(
        contractID: contractID,
        gardenID: gardenID,
        username: username,
        farmerUsername: farmerUsername,
        customerFullname: customerFullname,
        gardenName: gardenName,
      );
}

class _TreeProcessScreenState extends BaseState<TreeProcessScreen> {
  final int contractID;
  final int gardenID;
  final String username;
  final String farmerUsername;
  final String customerFullname;
  final String gardenName;

  _TreeProcessScreenState({
    @required this.contractID,
    @required this.gardenID,
    @required this.username,
    @required this.farmerUsername,
    @required this.customerFullname,
    @required this.gardenName,
  });

  static final VisitingRepo visitingRepo = VisitingRepo(
    apiClient: VisitingAPI(
      httpClient: http.Client(),
    ),
  );

  static final NotificationRepo notificationRepo = NotificationRepo(
    apiClient: NotificationAPI(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size35,
              right: Dimens.size10,
            ),
            child: Row(
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
                          gardenID: gardenID,
                          username: username,
                          farmerUsername: farmerUsername,
                          customerFullname: customerFullname,
                          gardenName: gardenName,
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
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size20,
              left: Dimens.size15,
            ),
            child: Text(
              translator.text(
                "tree_process",
              ),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Dimens.size16,
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
                child: BlocBuilder<TreeProcessBloc, TreeProcessState>(
                  builder: (context, state) {
                    if (state is TreeProcessLoaded) {
                      return Column(
                        children: [
                          for (var treeProcess in state.overviewList.result)
                            _treeProcessOverview(treeProcess.tp),
                        ],
                      );
                    }
                    if (state is TreeProcessEmpty) {
                      return Center(
                        child: Text(
                          translator.text(
                            "no_tree_process",
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

  Widget _treeProcessOverview(TreeProcess treeProcess) {
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
                      right: Dimens.size15,
                    ),
                    child: treeProcess.processImage == null
                        ? Image.asset(
                            'assets/images/empty_pic.png',
                          )
                        : Image.network(treeProcess
                            .processImage), //add img later //null checking
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size10,
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
                          top: Dimens.size10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: Dimens.size10,
                          ),
                          child: Text(
                            treeProcess.description == null
                                ? ""
                                : treeProcess.description, //treeDesc
                            style: TextStyle(
                              fontSize: Dimens.size16,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size30,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: Dimens.size10,
                              ),
                              child: Text(
                                translator.text("date"),
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: Dimens.size14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                DateFormat("dd/MM/yyyy")
                                    .format(treeProcess.date), //treeCode
                                style: TextStyle(
                                  fontSize: Dimens.size16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
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
