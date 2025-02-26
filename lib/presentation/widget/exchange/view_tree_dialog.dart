import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';

class ViewTreeDialog extends StatefulWidget {
  @override
  _ViewTreeDialogState createState() => _ViewTreeDialogState();
}

class _ViewTreeDialogState extends BaseState<ViewTreeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            translator.text(
              "tree_detail",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: BlocBuilder<RequestBloc, RequestState>(
          builder: (context, state) {
            if (state is TreeInfoByRequestLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: FractionalOffset.center,
                    child: Container(
                      height: Dimens.treeDetailImage,
                      child: state.treeInfo.image == null
                          ? Image.asset(
                              'assets/images/empty_pic.png',
                            )
                          : Image.network(state.treeInfo.image),
                      //add img later //null checking
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
                          state.treeInfo.treeCode, //treeCode
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
                            translator.text("plant_type"),
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
                            state.treeInfo.plantTypeName, //treePrice
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
                            state.treeInfo.gardenName, //treeStandard
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
                            translator.text("garden_address"),
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
                            "${state.treeInfo.address}, ${state.treeInfo.wardName}, ${state.treeInfo.districtName}, ${state.treeInfo.cityName}", //treeStandard
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
                            translator.text("phone"),
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
                            state.treeInfo.phone, //treeStandard
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
                            state.treeInfo.email == null
                                ? ""
                                : state.treeInfo.email, //treeStandard
                            style: TextStyle(
                              fontSize: Dimens.size20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
