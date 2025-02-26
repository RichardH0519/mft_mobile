import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_state.dart';
import 'package:mft_customer_side/logic/bloc/user/tree_type_by_username/tree_type_by_username_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/tree_type_by_username/tree_type_by_username_event.dart';
import 'package:mft_customer_side/logic/bloc/user/tree_type_by_username/tree_type_by_username_state.dart';
import 'package:mft_customer_side/logic/bloc/user/user_interest/user_interest_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_interest/user_interest_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_interest/user_interest_state.dart';
import 'package:mft_customer_side/model/tree_type/tree_type.dart';
import 'package:mft_customer_side/model/tree_type/tree_type_by_username.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class InterestScreen extends StatefulWidget {
  final String username;

  InterestScreen({@required this.username});

  @override
  _InterestScreenState createState() =>
      _InterestScreenState(username: username);
}

class _InterestScreenState extends BaseState<InterestScreen> {
  final String username;

  _InterestScreenState({@required this.username});

  List<DropdownMenuItem> _items = [];
  List<TreeType> _treeTypeIDs = [];
  //init value
  var _interestTreeInit1;
  var _interestTreeInit2;
  var _interestTreeInit3;

  int _interestTreeIDInit1 = 0;
  int _interestTreeIDInit2 = 0;
  int _interestTreeIDInit3 = 0;

  int _treeTypeID1 = 0;
  int _treeTypeID2 = 0;
  int _treeTypeID3 = 0;

  //check enable
  bool _isDeleteEnable1 = false;
  bool _isDeleteEnable2 = false;
  bool _isDeleteEnable3 = false;

  bool _isUpdateEnable1 = false;
  bool _isUpdateEnable2 = false;
  bool _isUpdateEnable3 = false;

  //selected value
  var _interestTree1;
  var _interestTree2;
  var _interestTree3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size35,
          ),
          child: Column(
            children: [
              Text(
                translator.text("interest"),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimens.size20,
                ),
              ),
              BlocBuilder<TreeTypeBloc, TreeTypeState>(
                builder: (blocContext, state) {
                  if (state is TreeTypeLoaded) {
                    _items = [];
                    _treeTypeIDs = [];
                    for (var treeType in state.treeTypeList.result) {
                      _items.add(
                        DropdownMenuItem(
                          child: Text(treeType.typeName),
                          value: treeType.typeName,
                        ),
                      );
                      _treeTypeIDs.add(treeType);
                    }

                    return BlocBuilder<TreeTypeByUsernameBloc,
                        TreeTypeByUsernameState>(
                      builder: (blocContext, state) {
                        if (state is TreeTypeByUsernameEmpty) {
                          _interestTreeInit1 = null;
                          _isDeleteEnable1 = false;
                          _interestTreeIDInit1 = 0;
                          _interestTree1 = null;

                          return _mainBody(
                            isDeleteEnable1: _isDeleteEnable1,
                            isDeleteEnable2: _isDeleteEnable2,
                            isDeleteEnable3: _isDeleteEnable3,
                            initID1: _interestTreeIDInit1,
                            initID2: _interestTreeIDInit2,
                            initID3: _interestTreeIDInit3,
                            username: username,
                          );
                        }

                        if (state is TreeTypeByUsernameLoaded) {
                          if (state.treeTypeByUsernameList.result.length == 1) {
                            _interestTreeInit1 =
                                state.treeTypeByUsernameList.result[0].typeName;
                            _isDeleteEnable1 = true;
                            _interestTreeIDInit1 =
                                state.treeTypeByUsernameList.result[0].it.id;

                            _interestTreeInit2 = null;
                            _isDeleteEnable2 = false;
                            _interestTreeIDInit2 = 0;
                            _interestTree2 = null;

                            _interestTree3 = null;
                          } else if (state
                                  .treeTypeByUsernameList.result.length ==
                              2) {
                            _interestTreeInit1 =
                                state.treeTypeByUsernameList.result[0].typeName;
                            _isDeleteEnable1 = true;
                            _interestTreeIDInit1 =
                                state.treeTypeByUsernameList.result[0].it.id;

                            _interestTreeInit2 =
                                state.treeTypeByUsernameList.result[1].typeName;
                            _isDeleteEnable2 = true;
                            _interestTreeIDInit2 =
                                state.treeTypeByUsernameList.result[1].it.id;

                            _interestTreeInit3 = null;
                            _isDeleteEnable3 = false;
                            _interestTreeIDInit3 = 0;
                            _interestTree3 = null;
                          } else if (state
                                  .treeTypeByUsernameList.result.length ==
                              3) {
                            _interestTreeInit1 =
                                state.treeTypeByUsernameList.result[0].typeName;
                            _isDeleteEnable1 = true;
                            _interestTreeIDInit1 =
                                state.treeTypeByUsernameList.result[0].it.id;

                            _interestTreeInit2 =
                                state.treeTypeByUsernameList.result[1].typeName;
                            _isDeleteEnable2 = true;
                            _interestTreeIDInit2 =
                                state.treeTypeByUsernameList.result[1].it.id;

                            _interestTreeInit3 =
                                state.treeTypeByUsernameList.result[2].typeName;
                            _isDeleteEnable3 = true;
                            _interestTreeIDInit3 =
                                state.treeTypeByUsernameList.result[2].it.id;
                          }

                          return _mainBody(
                            isDeleteEnable1: _isDeleteEnable1,
                            isDeleteEnable2: _isDeleteEnable2,
                            isDeleteEnable3: _isDeleteEnable3,
                            initID1: _interestTreeIDInit1,
                            initID2: _interestTreeIDInit2,
                            initID3: _interestTreeIDInit3,
                            username: username,
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.only(
                            top: Dimens.size50,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              BorderButton(
                title: translator.text("close"),
                color: Colors.red,
                function: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainBody({
    bool isDeleteEnable1,
    bool isDeleteEnable2,
    bool isDeleteEnable3,
    int initID1,
    int initID2,
    int initID3,
    String username,
  }) {
    return BlocListener<UserInterestBloc, UserInterestState>(
      listener: (listenerContext, state) {
        if (state is UserInterestDeleteFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("interest_delete_fail")),
              ),
            );
        }

        if (state is UserInterestDeleteSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("interest_delete_success")),
              ),
            );
        }

        if (state is UserInterestUpdateFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("interest_update_fail")),
              ),
            );
        }

        if (state is UserInterestUpdateSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("interest_update_success")),
              ),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: Dimens.size10,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: Dimens.size10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _interestRow1(),
                  ),
                  _updateButton(
                    _isUpdateEnable1,
                    initID1,
                    username,
                    _treeTypeID1,
                  ),
                  _deleteButton(
                    isDeleteEnable1,
                    initID1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: Dimens.size10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _interestRow2(),
                  ),
                  _updateButton(
                    _isUpdateEnable2,
                    initID2,
                    username,
                    _treeTypeID2,
                  ),
                  _deleteButton(
                    isDeleteEnable2,
                    initID2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: Dimens.size10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _interestRow3(),
                  ),
                  _updateButton(
                    _isUpdateEnable3,
                    initID3,
                    username,
                    _treeTypeID3,
                  ),
                  _deleteButton(
                    isDeleteEnable3,
                    initID3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _convertStringToInt(String selectedValue) {
    for (var element in _treeTypeIDs) {
      if (selectedValue == element.typeName) {
        return element.id;
      }
    }
  }

  Widget _interestRow1() {
    return SearchableDropdown.single(
      items: _items,
      value: _interestTree1 == null
          ? translator.text("interest_select_hint_single")
          : _interestTree1,
      hint: _interestTreeInit1 == null
          ? translator.text("interest_select_hint_single")
          : _interestTreeInit1,
      searchHint: null,
      onChanged: (value) {
        setState(() {
          _interestTree1 = value;
          if (_interestTree1 != null) {
            _isUpdateEnable1 = true;
            _treeTypeID1 = _convertStringToInt(_interestTree1);
          }
        });
      },
      dialogBox: false,
      isExpanded: true,
      displayClearIcon: false,
      menuConstraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }

  Widget _interestRow2() {
    return SearchableDropdown.single(
      items: _items,
      value: _interestTree2 == null
          ? translator.text("interest_select_hint_single")
          : _interestTree2,
      hint: _interestTreeInit2 == null
          ? translator.text("interest_select_hint_single")
          : _interestTreeInit2,
      searchHint: null,
      onChanged: (value) {
        setState(() {
          _interestTree2 = value;
          if (_interestTree2 != null) {
            _isUpdateEnable2 = true;
            _treeTypeID2 = _convertStringToInt(_interestTree2);
          }
        });
      },
      dialogBox: false,
      isExpanded: true,
      displayClearIcon: false,
      menuConstraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }

  Widget _interestRow3() {
    return SearchableDropdown.single(
      items: _items,
      value: _interestTree3 == null
          ? translator.text("interest_select_hint_single")
          : _interestTree3,
      hint: _interestTreeInit3 == null
          ? translator.text("interest_select_hint_single")
          : _interestTreeInit3,
      searchHint: null,
      onChanged: (value) {
        setState(() {
          _interestTree3 = value;
          if (_interestTree3 != null) {
            _isUpdateEnable3 = true;
            _treeTypeID3 = _convertStringToInt(_interestTree3);
          }
        });
      },
      dialogBox: false,
      isExpanded: true,
      displayClearIcon: false,
      menuConstraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }

  Widget _updateButton(
    bool isEnable,
    int id,
    String username,
    int treeTypeID,
  ) {
    return TextButton(
      onPressed: isEnable
          ? () async {
              BlocProvider.of<UserInterestBloc>(context).add(
                InterestUpdateBtnPressed(
                  id: id,
                  username: username,
                  treeTypeID: treeTypeID,
                ),
              );
              await Future.delayed(
                Duration(milliseconds: 500),
              );
              BlocProvider.of<TreeTypeByUsernameBloc>(context).add(
                GetTreeTypeByUsername(
                  username: username,
                ),
              );
            }
          : null,
      child: Text(
        translator.text("update"),
        style: TextStyle(
          color: isEnable ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
    );
  }

  Widget _deleteButton(
    bool isEnable,
    int id,
  ) {
    return TextButton(
      onPressed: isEnable
          ? () async {
              BlocProvider.of<UserInterestBloc>(context).add(
                InterestDeleteBtnPressed(
                  id: id,
                ),
              );
              await Future.delayed(
                Duration(milliseconds: 500),
              );
              BlocProvider.of<TreeTypeByUsernameBloc>(context).add(
                GetTreeTypeByUsername(
                  username: username,
                ),
              );
            }
          : null,
      child: Text(
        translator.text("detete"),
        style: TextStyle(
          color: isEnable ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
