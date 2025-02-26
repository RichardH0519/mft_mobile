import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_state.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_state.dart';
import 'package:mft_customer_side/model/tree/tree.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/home.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class TreeDetailDialog extends StatefulWidget {
  final User user;
  final Tree tree;

  TreeDetailDialog({@required this.user, @required this.tree});

  @override
  _TreeDetailDialogState createState() =>
      _TreeDetailDialogState(user: user, tree: tree);
}

class _TreeDetailDialogState extends BaseState<TreeDetailDialog> {
  final User user;
  final Tree tree;

  _TreeDetailDialogState({@required this.user, @required this.tree});

  int rentYear = 0;
  int maxRentYear = 5;
  var farmerUsername;
  var customerUsername;
  var customerFullname;
  final moneyFormat = NumberFormat.currency(locale: "vi", symbol: "");

  @override
  Widget build(BuildContext context) {
    return BlocListener<FarmerInfoBloc, FarmerInfoState>(
      listener: (builderContext, state) {
        if (state is FarmerInfoLoaded) {
          farmerUsername = state.user.username;
        }
      },
      child: BlocListener<ContractBloc, ContractState>(
        listener: (listenerContext, state) {
          if (state is ContractAddedFail) {
            ScaffoldMessenger.of(listenerContext)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(translator.text("add_contract_fail")),
                ),
              );

            Navigator.pop(context);
          }

          if (state is ContractAddedSuccess) {
            ScaffoldMessenger.of(listenerContext)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(translator.text("add_contract_success")),
                ),
              );

            BlocProvider.of<NotificationBloc>(context).add(
              AddRentNotification(
                farmerUsername: farmerUsername,
                userFullname: customerFullname,
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (builderContext) => Home(
                  user: user,
                ),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translator.text("tree_detail"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    height: Dimens.treeDetailImage,
                    child: tree.image == null
                        ? Image.asset(
                            'assets/images/empty_pic.png',
                          )
                        : Image.network(
                            tree.image), //add img later //null checking
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
                        "${moneyFormat.format(tree.price)} VND", //treePrice
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
                          translator.text("ship_fee"),
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
                          "${moneyFormat.format(tree.shipFee)} VND", //treePrice
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
                        tree.standard == null
                            ? ""
                            : tree.standard, //treeStandard
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
                      Expanded(
                        child: Text(
                          tree.yield == null
                              ? ""
                              : tree.yield.toString() +
                                  " kg / 1 vụ", //treeStandard
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
                  child: Text(
                    tree.description == null ? "" : tree.description,
                    style: TextStyle(
                      fontSize: Dimens.size16,
                      color: Colors.black,
                    ),
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
                          translator.text("rent_year"),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                            fontSize: Dimens.size18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _minus,
                        child: Icon(
                          Icons.remove,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        "$rentYear",
                        style: TextStyle(
                          fontSize: Dimens.size20,
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: _add,
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<UserInfoBloc, UserInfoState>(
                  builder: (context, state) {
                    if (state is UserInfoLoaded) {
                      customerFullname = state.user.fullname;
                    }

                    return Center(
                      child: Container(),
                    );
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: Dimens.size10,
                ),
                child: BorderButton(
                  color: ((rentYear == 0) || (rentYear > maxRentYear))
                      ? Colors.grey
                      : Theme.of(context).primaryColor,
                  title: translator.text("rent"),
                  function: ((rentYear == 0) || (rentYear > maxRentYear))
                      ? null
                      : () {
                          customerUsername = user.username;
                          BlocProvider.of<ContractBloc>(context).add(
                            AddContract(
                              treeID: tree.id,
                              customerUsername: customerUsername,
                              farmerUsername: farmerUsername,
                              numOfYear: rentYear,
                              totalPrice: ((tree.price * rentYear) +
                                  (tree.shipFee * tree.crops * rentYear)),
                              totalYield: (tree.yield * tree.crops * rentYear),
                              totalCrop: (tree.crops * rentYear),
                              shipFee: (tree.shipFee * tree.crops * rentYear),
                            ),
                          );
                        },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _add() {
    setState(() {
      rentYear++;
    });
  }

  void _minus() {
    setState(() {
      if (rentYear != 0) {
        rentYear--;
      }
    });
  }
}
