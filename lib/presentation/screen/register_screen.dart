import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_bloc.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_state.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_bloc.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_event.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_state.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_state.dart';
import 'package:mft_customer_side/logic/bloc/user/register/register_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/register/register_event.dart';
import 'package:mft_customer_side/logic/bloc/user/register/register_state.dart';
import 'package:mft_customer_side/model/address/district.dart';
import 'package:mft_customer_side/model/address/ward.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  bool _isEnable = false;

  //text controller
  var _fullnameController = TextEditingController();
  var _chosenDate = "";
  var _genderList = ["Female", "Male"];
  var _selectedGender = "";
  var _gender;
  var _addressController = TextEditingController();
  var _phoneController = TextEditingController();
  List<DropdownMenuItem> _items = [];
  List<int> _selectedItems = [];
  var _interestTree1;
  var _interestTree2;
  var _interestTree3;
  List<DropdownMenuItem> _cities = [];
  List<DropdownMenuItem> _districts = [];
  List<District> _districtsID = [];
  String _selectedDistrict;
  List<DropdownMenuItem> _wards = [];
  List<Ward> _wardsID = [];
  String _selectedWard;
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<TreeTypeBloc, TreeTypeState>(
        builder: (blocContext, state) {
          if (state is TreeTypeLoaded) {
            _items = [];
            for (var treeType in state.treeTypeList.result) {
              _items.add(
                DropdownMenuItem(
                  child: Text(treeType.typeName),
                  value: treeType.typeName,
                ),
              );
            }

            return BlocListener<RegisterBloc, RegisterState>(
              listener: (listenerContext, state) {
                if (state is RegisterFail) {
                  ScaffoldMessenger.of(listenerContext)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(translator.text("sign_up_failed")),
                      ),
                    );
                }

                if (state is RegisterSuccess) {
                  ScaffoldMessenger.of(listenerContext)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(translator.text("sign_up_success")),
                      ),
                    );

                  Navigator.popAndPushNamed(context, '/login');
                }
              },
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.size30,
                        ),
                        child: Image.asset(
                          'assets/images/app_logo_2.png',
                          height: Dimens.loginIconSize,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: Dimens.size50,
                          right: Dimens.size50,
                          top: Dimens.size30,
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
                                controller: _fullnameController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _dobRow(_chosenDate),
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
                                controller: _addressController,
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

                                    return _wardRow();
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
                                controller: _phoneController,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: Dimens.size10,
                                  ),
                                  child: Text(
                                    translator.text("interest"),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimens.size18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: Dimens.size10,
                                  ),
                                  child: _interestRow(),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Dimens.size10,
                              ),
                              child: _infoRow(
                                context: context,
                                icon: Icons.person,
                                label: translator.text("username"),
                                length: 50,
                                error: translator.text("username_validate"),
                                controller: _usernameController,
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
                                controller: _passwordController,
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
                                controller: _rePasswordController,
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
                          title: translator.text("sign_up"),
                          color: _isEnable
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          function: _isEnable
                              ? () {
                                  if (_formKey.currentState.validate() &&
                                      _chosenDate.isNotEmpty &&
                                      _selectedGender.isNotEmpty) {
                                    if (_selectedGender == "Female") {
                                      _gender = 0;
                                    } else
                                      _gender = 1;
                                    if (_selectedItems.isEmpty) {
                                      _interestTree1 = 0;
                                      _interestTree2 = 0;
                                      _interestTree3 = 0;
                                    } else {
                                      if (_selectedItems.length == 1) {
                                        _interestTree1 = _selectedItems[0] + 1;
                                        _interestTree2 = 0;
                                        _interestTree3 = 0;
                                      } else if (_selectedItems.length == 2) {
                                        _interestTree1 = _selectedItems[0] + 1;
                                        _interestTree2 = _selectedItems[1] + 1;
                                        _interestTree3 = 0;
                                      } else {
                                        _interestTree1 = _selectedItems[0] + 1;
                                        _interestTree2 = _selectedItems[1] + 1;
                                        _interestTree3 = _selectedItems[2] + 1;
                                      }
                                    }
                                    //call register function
                                    BlocProvider.of<RegisterBloc>(context).add(
                                      RegisterBtnPressed(
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                        fullname: _fullnameController.text,
                                        gender: _gender,
                                        dateOfBirth: _chosenDate,
                                        address: _addressController.text,
                                        district: _convertDistrictStringToInt(
                                            _selectedDistrict),
                                        ward: _convertWardStringToInt(
                                            _selectedWard),
                                        phone: _phoneController.text,
                                        interestTree1: _interestTree1,
                                        interestTree2: _interestTree2,
                                        interestTree3: _interestTree3,
                                      ),
                                    );
                                  }
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
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
                  color: Colors.red,
                ),
                counterText: "",
              ),
              maxLength: length,
              textDirection: ui.TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              textInputAction: TextInputAction.none,
              onChanged: (value) {
                setState(() {
                  _isEnable = true;
                });
              },
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
      hint: Text(
        translator.text("select_district"),
        style: TextStyle(
          color: Colors.red,
        ),
      ),
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
      hint: Text(
        translator.text("select_ward"),
        style: TextStyle(
          color: Colors.red,
        ),
      ),
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
              _isEnable = true;
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
                style: TextStyle(
                  fontSize: Dimens.size16,
                  color: Colors.red,
                ),
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
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
              _isEnable = true;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
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
                  color: Colors.red,
                ),
                counterText: "",
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
              textDirection: ui.TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              textInputAction: TextInputAction.none,
              onChanged: (value) {
                setState(() {
                  _isEnable = true;
                });
              },
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

  Widget _interestRow() {
    return SearchableDropdown.multiple(
      items: _items,
      selectedItems: _selectedItems,
      hint: translator.text(
        "interest_select_hint",
      ),
      searchHint: translator.text(
        "interest_select_hint",
      ),
      validator: (selectedItemsForValidator) {
        if (selectedItemsForValidator.length > 3) {
          return (translator.text("interest_validate"));
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _selectedItems = value;
        });
      },
      doneButton: (selectedItemsDone, doneContext) {
        return (ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: selectedItemsDone.length > 3
                ? null
                : () {
                    Navigator.pop(doneContext);
                    setState(() {});
                  },
            child: Text(translator.text("save"))));
      },
      closeButton: null,
      isExpanded: true,
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
                  color: Colors.red,
                ),
                counterText: "",
              ),
              maxLength: 16,
              obscureText: true,
              textDirection: ui.TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              textInputAction: TextInputAction.none,
              onChanged: (value) {
                setState(() {
                  _isEnable = true;
                });
              },
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
                  color: Colors.red,
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
