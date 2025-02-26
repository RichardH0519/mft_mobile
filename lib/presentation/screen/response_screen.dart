import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_rate/contract_rate_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_rate/contract_rate_state.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_state.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/package/package_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_event.dart';
import 'package:mft_customer_side/logic/bloc/package/package_state.dart';
import 'package:mft_customer_side/model/contract/contract_overview.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ResponseScreen extends StatefulWidget {
  final String plantTypeName;
  final int exchangeYield;
  final int exchangeRequestID;
  final String username;
  final String requestUsername;

  ResponseScreen({
    @required this.plantTypeName,
    @required this.exchangeYield,
    @required this.exchangeRequestID,
    @required this.username,
    this.requestUsername,
  });

  @override
  _ResponseScreenState createState() => _ResponseScreenState(
        plantTypeName: plantTypeName,
        exchangeYield: exchangeYield,
        exchangeRequestID: exchangeRequestID,
        username: username,
        requestUsername: requestUsername,
      );
}

class _ResponseScreenState extends BaseState<ResponseScreen> {
  final String plantTypeName;
  final int exchangeYield;
  final int exchangeRequestID;
  final String username;
  final String requestUsername;

  _ResponseScreenState({
    @required this.plantTypeName,
    @required this.exchangeYield,
    @required this.exchangeRequestID,
    @required this.username,
    this.requestUsername,
  });

  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem> _items = [];
  List<ContractOverview> _contracts = [];

  var _selectedValue;

  //text controller
  var _weightController = TextEditingController();
  var _requestWeightController = TextEditingController();
  int _requestWeight;
  var _responseYield;

  int _selectedContractID;

  bool _hasChose = false;
  bool _wrongFormat = false;
  bool _isTooMuch = false;

  double _requestRate;
  double _responseRate;
  double _exchangeRate;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResponseBloc, ResponseState>(
      listener: (listenerContext, state) {
        if (state is ResponseCreateFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("add_response_fail")),
              ),
            );
        }

        if (state is ResponseCreateSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("add_request_success")),
              ),
            );

          BlocProvider.of<NotificationBloc>(context).add(
            SendResponseNotification(
              requestusername: requestUsername,
              plantTypename: plantTypeName,
            ),
          );

          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: FractionalOffset.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: Dimens.size35,
                      ),
                      child: Text(
                        translator.text("exchange_response"),
                        style: TextStyle(
                          fontSize: Dimens.size25,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.size15,
                    ),
                    child: BlocBuilder<PackageBloc, PackageState>(
                      builder: (context, state) {
                        if (state is YieldLoaded) {
                          _responseYield =
                              ((state.yields.yield) * (50 / 100)).round();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                translator.text("response_max_yield"),
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                "$_responseYield kg",
                                style: TextStyle(
                                  fontSize: Dimens.size20,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                translator.text("response_max_yield"),
                                style: TextStyle(
                                  color: Colors.red
                                ),
                              ),
                              Text(
                                "?? kg",
                                style: TextStyle(
                                  fontSize: Dimens.size20,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.size10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          translator.text("request_max_yield"),
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "$exchangeYield kg",
                          style: TextStyle(
                            fontSize: Dimens.size20,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.size15,
                      left: Dimens.size10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Tôi muốn đổi",
                          style: TextStyle(
                            fontSize: Dimens.size18,
                            color: Colors.black87,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.size5,
                          ),
                          child: Container(
                            width: Dimens.size50,
                            child: TextFormField(
                              enabled: _hasChose,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.size5,
                                ),
                                counterText: "",
                              ),
                              style: TextStyle(
                                fontSize: Dimens.size20,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color:
                                    _wrongFormat ? Colors.red : Colors.black87,
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  if (num.parse(value) is int) {
                                    if (num.parse(value) != 0 &&
                                        num.parse(value) <= _responseYield) {
                                      _wrongFormat = false;
                                      _requestWeight =
                                          (num.parse(value) * _exchangeRate)
                                              .round();
                                      if (_requestWeight <= exchangeYield) {
                                        _isTooMuch = false;
                                      } else {
                                        _isTooMuch = true;
                                      }
                                      _requestWeightController.text =
                                          _requestWeight.toString();
                                    } else {
                                      _wrongFormat = true;
                                    }
                                  } else {
                                    _wrongFormat = true;
                                  }
                                });
                              },
                              controller: _weightController,
                            ),
                          ),
                        ),
                        Text(
                          " kg",
                          style: TextStyle(
                            fontSize: Dimens.size18,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.size5,
                              right: Dimens.size10,
                            ),
                            child: BlocBuilder<ContractBloc, ContractState>(
                              builder: (blocContext, state) {
                                if (state is ContractOverviewsLoaded) {
                                  _items = [];
                                  _contracts = [];
                                  for (var contract
                                      in state.contractOverviewList.result) {
                                    if (contract.status == 1) {
                                      _items.add(
                                        DropdownMenuItem(
                                          child: Text(
                                              "${contract.treeCode} - ${contract.plantTypeName} - ${contract.gardenName}"),
                                          value:
                                              "${contract.treeCode} - ${contract.plantTypeName} - ${contract.gardenName}",
                                        ),
                                      );
                                      _contracts.add(contract);
                                    }
                                  }
                                  return _selectTree();
                                }

                                if (state is ContractOverviewsEmpty) {
                                  return _selectTree();
                                }

                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.size10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "lấy",
                          style: TextStyle(
                            fontSize: Dimens.size18,
                            color: Colors.black87,
                          ),
                        ),
                        BlocBuilder<ContractRateBloc, ContractRateState>(
                          builder: (context, state) {
                            if (state is ContractRateLoaded) {
                              _requestRate = (state.contractRate.totalPrice /
                                  state.contractRate.totalYield);

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.size5,
                                ),
                                child: Container(
                                  width: Dimens.size50,
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: Dimens.size5,
                                      ),
                                      counterText: "",
                                    ),
                                    style: TextStyle(
                                      fontSize: Dimens.size20,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic,
                                      color: _isTooMuch
                                          ? Colors.red
                                          : Colors.black87,
                                    ),
                                    controller: _requestWeightController,
                                  ),
                                ),
                              );
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        Text(
                          " kg",
                          style: TextStyle(
                            fontSize: Dimens.size18,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.size10,
                              right: Dimens.size10,
                            ),
                            child: Text(
                              plantTypeName,
                              style: TextStyle(
                                fontSize: Dimens.size18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.size30,
                    ),
                    child: BorderButton(
                      title: translator.text("send_response"),
                      color: Theme.of(context).primaryColor,
                      function: () {
                        if ((int.parse(_weightController.text) != 0) &&
                            _requestWeight <= exchangeYield &&
                            int.parse(_weightController.text) <=
                                _responseYield) {
                          BlocProvider.of<ResponseBloc>(context).add(
                            CreateResponse(
                              exchangeRequestID: exchangeRequestID,
                              weight: int.parse(_weightController.text),
                              contractID: _selectedContractID,
                              username: username,
                              requestWeight: _requestWeight,
                            ),
                          );
                        } else {}
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: Dimens.size35,
                left: Dimens.size15,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: Dimens.size25,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectTree() {
    return SearchableDropdown.single(
      items: _items,
      value: _selectedValue,
      hint: translator.text("choose_tree"),
      searchHint: translator.text("choose_tree"),
      displayClearIcon: false,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
          if (_selectedValue != null) {
            _responseRate = _getResponseRate(_selectedValue);
            _exchangeRate = _responseRate / _requestRate;
            _hasChose = true;
            _selectedContractID = _getResponseContractID(_selectedValue);
            BlocProvider.of<PackageBloc>(context).add(
              GetYield(
                username: username,
                contractID: _selectedContractID,
              ),
            );
          }
        });
      },
      isExpanded: true,
    );
  }

  double _getResponseRate(String selectedValue) {
    for (var contract in _contracts) {
      if (selectedValue ==
          "${contract.treeCode} - ${contract.plantTypeName} - ${contract.gardenName}") {
        return (contract.totalPrice / contract.totalYield);
      }
    }
  }

  int _getResponseContractID(String selectedValue) {
    for (var contract in _contracts) {
      if (selectedValue ==
          "${contract.treeCode} - ${contract.plantTypeName} - ${contract.gardenName}") {
        return contract.contractID;
      }
    }
  }
}
