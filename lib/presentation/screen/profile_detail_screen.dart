import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mft_customer_side/logic/api/tree_type/tree_type_api.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/api/user/user_interest_api.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_bloc.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_state.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_bloc.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_event.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_state.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_event.dart';
import 'package:mft_customer_side/logic/bloc/user/edit/edit_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/edit/edit_event.dart';
import 'package:mft_customer_side/logic/bloc/user/edit/edit_state.dart';
import 'package:mft_customer_side/logic/bloc/user/tree_type_by_username/tree_type_by_username_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/tree_type_by_username/tree_type_by_username_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_state.dart';
import 'package:mft_customer_side/logic/bloc/user/user_interest/user_interest_bloc.dart';
import 'package:mft_customer_side/logic/repo/tree_type/tree_type_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_interest_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/model/address/district.dart';
import 'package:mft_customer_side/model/address/ward.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';
import 'package:mft_customer_side/presentation/screen/interest_screen.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ProfileDetailScreen extends StatefulWidget {
  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends BaseState<ProfileDetailScreen> {
  static final UserRepo userRepo = UserRepo(
    apiClient: UserAPI(
      httpClient: http.Client(),
    ),
  );

  static final TreeTypeRepo treeTypeRepo = TreeTypeRepo(
    apiClient: TreeTypeAPI(
      httpClient: http.Client(),
    ),
  );

  static final UserInterestRepo userInterestRepo = UserInterestRepo(
    apiClient: UserInterestAPI(
      httpClient: http.Client(),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  //text controller
  var _fullnameController = TextEditingController();
  var _chosenDate = "";
  var _genderList = ["Female", "Male"];
  var _selectedGender = "";
  var _initGender = "";
  var _gender;
  var _addressController = TextEditingController();
  var _phoneController = TextEditingController();
  var _emailController = TextEditingController();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _rePasswordController = TextEditingController();
  List<DropdownMenuItem> _cities = [];
  List<DropdownMenuItem> _districts = [];
  List<District> _districtsID = [];
  String _selectedDistrict;
  List<DropdownMenuItem> _wards = [];
  List<Ward> _wardsID = [];
  String _selectedWard;
  var _initDistrictID;
  var _initDistrict;
  var _initWardID;
  var _initWard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (blocContext, state) {
            if (state is UserInfoLoaded) {
              //set user dob
              var _initDate =
                  DateFormat("yyyy-MM-dd").format(state.user.dateOfBirth);
              //set user gender
              if (state.user.gender == 0) {
                _initGender = "Female";
              } else {
                _initGender = "Male";
              }

              _initDistrictID = state.user.district;
              _initDistrict = state.user.districtName;

              _initWardID = state.user.ward;
              _initWard = state.user.wardName;

              return BlocListener<EditBloc, EditState>(
                listener: (listenerContext, state) {
                  if (state is EditFail) {
                    ScaffoldMessenger.of(listenerContext)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(translator.text("edit_failed")),
                        ),
                      );
                  }

                  if (state is EditSuccess) {
                    ScaffoldMessenger.of(listenerContext)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(translator.text("edit_success")),
                        ),
                      );
                  }
                },
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: Dimens.size50,
                          right: Dimens.size50,
                          top: Dimens.size65,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _infoRow(
                                context: context,
                                icon: Icons.person,
                                label: translator.text("fullname"),
                                length: 50,
                                error: translator.text("fullname_validate"),
                                controller: _fullnameController
                                  ..text = state.user.fullname,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _dobRow(
                                _chosenDate.isEmpty ? _initDate : _chosenDate,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _genderRow(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _infoRow(
                                context: context,
                                icon: Icons.house,
                                label: translator.text("house_number"),
                                length: 100,
                                error: translator.text("address_validate"),
                                controller: _addressController
                                  ..text = state.user.address,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _cityRow(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: BlocBuilder<DistrictBloc, DistrictState>(
                                builder: (blocContext, state) {
                                  if (state is DistrictLoaded) {
                                    _districts = [];
                                    _districtsID = [];
                                    for (var district
                                        in state.districtList.result) {
                                      _districts.add(
                                        DropdownMenuItem(
                                          child: Text(
                                            district.districtName,
                                          ),
                                          value: district.districtName,
                                        ),
                                      );
                                      _districtsID.add(district);
                                    }

                                    return _districtRow();
                                  }

                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: BlocBuilder<WardBloc, WardState>(
                                builder: (blocContext, state) {
                                  if (state is WardLoaded) {
                                    _wards = [];
                                    _wardsID = [];
                                    for (var ward in state.wardList.result) {
                                      _wards.add(
                                        DropdownMenuItem(
                                          child: Text(
                                            ward.wardName,
                                          ),
                                          value: ward.wardName,
                                        ),
                                      );
                                      _wardsID.add(ward);
                                    }
                                  }

                                  return _wardRow();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _numberRow(
                                context: context,
                                icon: Icons.phone,
                                label: translator.text("phone"),
                                controller: _phoneController
                                  ..text = state.user.phone,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _emailRow(
                                context: context,
                                icon: Icons.mail,
                                label: translator.text("email"),
                                length: 50,
                                error: translator.text("email_validate"),
                                controller: _emailController
                                  ..text = state.user.email,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    translator.text("interest"),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimens.size18,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builderContext) =>
                                              MultiBlocProvider(
                                            providers: [
                                              BlocProvider<TreeTypeBloc>(
                                                create: (blocContext) =>
                                                    TreeTypeBloc(
                                                        repo: treeTypeRepo)
                                                      ..add(
                                                        GetTreeType(),
                                                      ),
                                              ),
                                              BlocProvider<
                                                  TreeTypeByUsernameBloc>(
                                                create: (blocContext) =>
                                                    TreeTypeByUsernameBloc(
                                                        repo: userRepo)
                                                      ..add(
                                                        GetTreeTypeByUsername(
                                                          username: state
                                                              .user.username,
                                                        ),
                                                      ),
                                              ),
                                              BlocProvider<UserInterestBloc>(
                                                create: (blocContext) =>
                                                    UserInterestBloc(
                                                  repo: userInterestRepo,
                                                ),
                                              ),
                                            ],
                                            child: InterestScreen(
                                              username: state.user.username,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      translator.text(
                                        "edit",
                                      ),
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: AbsorbPointer(
                                absorbing: true,
                                child: _infoRow(
                                  context: context,
                                  icon: Icons.person,
                                  label: translator.text("username"),
                                  length: 50,
                                  error: translator.text("username_validate"),
                                  controller: _usernameController
                                    ..text = state.user.username,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _passwordRow(
                                context: context,
                                icon: Icons.password,
                                label: translator.text("password"),
                                controller: _passwordController
                                  ..text = state.user.password,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _rePasswordRow(
                                context: context,
                                icon: Icons.password,
                                label: translator.text("re_password"),
                                controller: _rePasswordController
                                  ..text = state.user.password,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: Dimens.size10,
                        ),
                        child: BorderButton(
                          title: translator.text("edit"),
                          color: Theme.of(context).primaryColor,
                          function: () {
                            if (_chosenDate.isEmpty) {
                              _chosenDate = _initDate;
                            }
                            if (_selectedGender.isEmpty) {
                              _selectedGender = _initGender;
                            }
                            if (_formKey.currentState.validate() &&
                                _chosenDate.isNotEmpty &&
                                _selectedGender.isNotEmpty) {
                              if (_selectedGender == "Female") {
                                _gender = 0;
                              } else
                                _gender = 1;

                              //call update function
                              BlocProvider.of<EditBloc>(context).add(
                                EditBtnPressed(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                  fullname: _fullnameController.text,
                                  gender: _gender,
                                  dateOfBirth: _chosenDate,
                                  address: _addressController.text,
                                  district: _selectedDistrict != null
                                      ? _convertDistrictStringToInt(
                                          _selectedDistrict)
                                      : _initDistrictID,
                                  ward: _selectedWard != null
                                      ? _convertWardStringToInt(_selectedWard)
                                      : _initWardID,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.size50,
                ),
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow(
      {BuildContext context,
      IconData icon,
      String label,
      int length,
      String error,
      TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: Dimens.thick02),
        borderRadius: BorderRadius.circular(Dimens.size8),
        color: Theme.of(context).accentColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size10,
            ),
            child: Icon(icon),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                counterText: "",
              ),
              maxLength: length,
              textDirection: ui.TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              textInputAction: TextInputAction.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return error;
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _cityRow() {
    return SearchableDropdown.single(
      items: _cities,
      hint: translator.text("HCM_city"),
      searchHint: null,
      onChanged: (value) {},
      dialogBox: false,
      isExpanded: true,
      displayClearIcon: false,
      menuConstraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }

  Widget _districtRow() {
    return SearchableDropdown.single(
      items: _districts,
      value: _selectedDistrict,
      hint: _initDistrict,
      searchHint: null,
      onChanged: (value) {
        setState(() {
          _selectedDistrict = value;
          BlocProvider.of<WardBloc>(context).add(
            GetWards(
              districtID: _convertDistrictStringToInt(_selectedDistrict),
            ),
          );
        });
      },
      dialogBox: false,
      isExpanded: true,
      displayClearIcon: false,
      menuConstraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }

  int _convertDistrictStringToInt(String selectedValue) {
    for (var element in _districtsID) {
      if (selectedValue == element.districtName) {
        return element.id;
      }
    }
  }

  Widget _wardRow() {
    return SearchableDropdown.single(
      items: _wards,
      value: _selectedWard,
      hint: _initWard,
      searchHint: null,
      onChanged: (value) {
        setState(() {
          _selectedWard = value;
        });
      },
      dialogBox: false,
      isExpanded: true,
      displayClearIcon: false,
      menuConstraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }

  int _convertWardStringToInt(String selectedValue) {
    for (var element in _wardsID) {
      if (selectedValue == element.wardName) {
        return element.id;
      }
    }
  }

  Widget _emailRow(
      {BuildContext context,
      IconData icon,
      String label,
      int length,
      String error,
      TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: Dimens.thick02),
        borderRadius: BorderRadius.circular(Dimens.size8),
        color: Theme.of(context).accentColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size10,
            ),
            child: Icon(icon),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                counterText: "",
              ),
              maxLength: length,
              textDirection: ui.TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              textInputAction: TextInputAction.none,
              validator: (value) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = RegExp(pattern);
                if (value == null || value.isEmpty) {
                  return null;
                } else {
                  if (!regex.hasMatch(value)) {
                    return error;
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _dobRow(String date) {
    final maxDay = DateTime.now().day;
    final maxMonth = DateTime.now().month;
    final minYear = DateTime.now().year - 100;
    final maxYear = DateTime.now().year - 18;
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(minYear),
          maxTime: DateTime(maxYear, maxMonth, maxDay),
          onConfirm: (date) {
            setState(() {
              _chosenDate = DateFormat("yyyy-MM-dd").format(date);
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.vi,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.size20),
        decoration: BoxDecoration(
          border: Border.all(width: Dimens.thick02),
          borderRadius: BorderRadius.circular(Dimens.size8),
          color: Theme.of(context).accentColor,
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
              child: Icon(Icons.date_range),
            ),
            Padding(
              padding: const EdgeInsets.only(right: Dimens.size30),
              child: Text(
                translator.text("birthday"),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Text(
              date,
              style: Theme.of(context).textTheme.headline5,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                right: Dimens.size10,
              ),
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderRow() {
    return Row(
      children: [
        _addRadioButton(0, "Female"),
        _addRadioButton(1, "Male"),
      ],
    );
  }

  Widget _addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: _genderList[btnValue],
          groupValue: _selectedGender.isEmpty ? _initGender : _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Widget _numberRow(
      {BuildContext context,
      IconData icon,
      String label,
      TextEditingController controller}) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: Dimens.thick02),
        borderRadius: BorderRadius.circular(Dimens.size8),
        color: Theme.of(context).accentColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size10,
            ),
            child: Icon(icon),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                counterText: "",
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
              textDirection: ui.TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              textInputAction: TextInputAction.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translator.text("phone_validate");
                } else if ((value.length < 10) && value.isNotEmpty) {
                  return translator.text("phone_10_num_validate");
                } else if (!regExp.hasMatch(value)) {
                  return translator.text("invalid_phone");
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordRow(
      {BuildContext context,
      IconData icon,
      String label,
      TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: Dimens.thick02),
        borderRadius: BorderRadius.circular(Dimens.size8),
        color: Theme.of(context).accentColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size10,
            ),
            child: Icon(icon),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                counterText: "",
              ),
              maxLength: 16,
              obscureText: true,
              textDirection: ui.TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              textInputAction: TextInputAction.none,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translator.text("password_validate");
                } else if ((value.length < 4) && value.isNotEmpty) {
                  return translator.text("password_min_validate");
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _rePasswordRow(
      {BuildContext context,
      IconData icon,
      String label,
      TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: Dimens.thick02),
        borderRadius: BorderRadius.circular(Dimens.size8),
        color: Theme.of(context).accentColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size10,
            ),
            child: Icon(icon),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                counterText: "",
              ),
              maxLength: 16,
              obscureText: true,
              textDirection: ui.TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translator.text("re_password_validate");
                } else if ((value != _passwordController.text) &&
                    value.isNotEmpty) {
                  return translator.text("re_password_validate_false");
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
