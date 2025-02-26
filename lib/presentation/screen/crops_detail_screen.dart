import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/contract_detail/contract_detail_api.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract-detail_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract_detail_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/repo/contract_detail/contract_detail_repo.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';
import 'package:mft_customer_side/model/contract_detail/contract_detail.dart';
import 'package:mft_customer_side/model/contract_detail/contract_detail_info.dart';
import 'package:mft_customer_side/presentation/widget/tree_process/delivery_date_dialog.dart';

class CropsDetailScreen extends StatefulWidget {
  final String farmerUsername;
  final int contractNumber;

  CropsDetailScreen(
      {@required this.farmerUsername, @required this.contractNumber});

  @override
  _CropsDetailScreenState createState() => _CropsDetailScreenState(
        farmerUsername: farmerUsername,
        contractNumber: contractNumber,
      );
}

class _CropsDetailScreenState extends BaseState<CropsDetailScreen> {
  final String farmerUsername;
  final int contractNumber;

  _CropsDetailScreenState(
      {@required this.farmerUsername, @required this.contractNumber});

  static final ContractDetailRepo contractDetailRepo = ContractDetailRepo(
    apiClient: ContractDetailAPI(
      httpClient: http.Client(),
    ),
  );

  static final NotificationRepo notificationRepo = NotificationRepo(
    apiClient: NotificationAPI(),
  );

  DateTime start;
  DateTime end;

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
              left: Dimens.size15,
            ),
            child: Text(
              translator.text("crops_list"),
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
                child: BlocBuilder<ContractDetailBloc, ContractDetailState>(
                  builder: (context, state) {
                    if (state is ContractDetailsLoaded) {
                      return Column(
                        children: [
                          for (var contractDetail
                              in state.contractDetailList.result)
                            _cropOverview(contractDetail),
                        ],
                      );
                    }

                    if (state is ContractDetailsEmpty) {
                      return Center(
                        child: Text(translator.text("list_empty")),
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

  Widget _cropOverview(ContractDetailInfo detail) {
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
                      translator.text("harvest_date"),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: Dimens.size14,
                      ),
                    ),
                  ),
                  _returnHarvestDate(
                    detail.cd.startHarvest,
                    detail.cd.endHarvest,
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size10,
                    ),
                    child: Text(
                      translator.text("delivery_date"),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: Dimens.size14,
                      ),
                    ),
                  ),
                  _returnDeliveryDate(
                    detail.cd.startHarvest,
                    detail.cd.endHarvest,
                    detail.cd.deliveryDate,
                    detail.cd.contractID,
                    detail.cd.status,
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimens.size10,
                    ),
                    child: Text(
                      translator.text("detail_yield"),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: Dimens.size14,
                      ),
                    ),
                  ),
                  Text(
                    "${detail.cd.yield} kg",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      fontSize: Dimens.size16,
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
                      translator.text("received_yield"),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: Dimens.size14,
                      ),
                    ),
                  ),
                  Text(
                    "${detail.remainYield} kg",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      fontSize: Dimens.size16,
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
                      translator.text("exchange_yield"),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: Dimens.size14,
                      ),
                    ),
                  ),
                  Text(
                    "${detail.exchangedYield} kg",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      fontSize: Dimens.size16,
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
                  _returnTextByStatus(detail.cd.status),
                ],
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
          translator.text("start_crop"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.green,
          ),
        );
        break;
      case 1:
        return Text(
          translator.text("harvesting"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.orange.shade600,
          ),
        );
        break;
      case 2:
        return Text(
          translator.text("end_crop"),
          //status
          style: TextStyle(
            fontSize: Dimens.size16,
            fontWeight: FontWeight.w700,
            color: Colors.purple,
          ),
        );
        break;
      case 3:
        return Text(
          translator.text("delivered"),
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

  Widget _returnHarvestDate(DateTime startHarvest, DateTime endHarvest) {
    if ((DateFormat("dd/MM/yyyy").format(startHarvest) != "01/01/0001") &&
        (DateFormat("dd/MM/yyyy").format(endHarvest) != "01/01/0001")) {
      start = startHarvest.add(
        Duration(days: 3),
      );
      end = endHarvest.add(
        Duration(
          days: 3,
        ),
      );

      var startDate = DateFormat("dd/MM/yyyy").format(
        startHarvest.add(
          Duration(days: 3),
        ),
      );
      var endDate = DateFormat("dd/MM/yyyy").format(
        endHarvest.add(
          Duration(
            days: 3,
          ),
        ),
      );

      return Padding(
        padding: const EdgeInsets.only(
          right: Dimens.size30,
        ),
        child: Text(
          "$startDate - $endDate",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            fontSize: Dimens.size16,
          ),
        ),
      );
    } else {
      return Text("");
    }
  }

  Widget _returnDeliveryDate(
    DateTime startHarvest,
    DateTime endHarvest,
    DateTime deliveryDate,
    int contractID,
    int status,
  ) {
    if ((DateFormat("dd/MM/yyyy").format(startHarvest) != "01/01/0001") &&
        (DateFormat("dd/MM/yyyy").format(endHarvest) != "01/01/0001")) {
      var delivery = DateFormat("dd/MM/yyyy").format(deliveryDate);

      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: Dimens.size30,
            ),
            child: Text(
              delivery == '01/01/0001' ? "" : "$delivery",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                fontSize: Dimens.size16,
              ),
            ),
          ),
          status == 0
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: Dimens.size25,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider<ContractDetailBloc>(
                              create: (blocContext) => ContractDetailBloc(
                                repo: contractDetailRepo,
                              ),
                            ),
                            BlocProvider<NotificationBloc>(
                              create: (blocContext) => NotificationBloc(
                                repo: notificationRepo,
                              ),
                            ),
                          ],
                          child: DeliveryDateDialog(
                            contractID: contractID,
                            startDate: start,
                            endDate: end,
                            farmerUsername: farmerUsername,
                            contractNumber: contractNumber,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                  ),
                )
              : Container(),
        ],
      );
    } else {
      return Text("");
    }
  }
}
