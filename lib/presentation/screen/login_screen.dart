import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/presentation/screen/home.dart';
import 'package:mft_customer_side/logic/bloc/user/login/login_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/login/login_event.dart';
import 'package:mft_customer_side/logic/bloc/user/login/login_state.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (listenerContext, state) {
          if (state is LoginFail) {
            ScaffoldMessenger.of(listenerContext)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(translator.text("login_failed")),
                ),
              );
          }

          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (builderContext) => Home(
                  user: state.user,
                ),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.size70,
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
                  top: Dimens.size50,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: Dimens.size10,
                      ),
                      child: _userRow(
                        context: context,
                        icon: Icons.person,
                        label: translator.text("username"),
                        controller: _usernameController,
                      ),
                    ),
                    _passwordRow(
                      context: context,
                      icon: Icons.password,
                      label: translator.text("password"),
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: Dimens.size15),
                    child: BorderButton(
                      title: translator.text("login"),
                      color: _isEnable
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      function: _isEnable
                          ? () {
                              if (_formKey.currentState.validate()) {
                                //call login function
                                BlocProvider.of<LoginBloc>(context).add(
                                  LoginBtnPressed(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              }
                            }
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userRow(
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
              maxLength: 50,
              textDirection: TextDirection.ltr,
              controller: controller,
              style: Theme.of(context).textTheme.headline5,
              onChanged: (value) {
                setState(() {
                  _isEnable = true;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translator.text("username_validate");
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
              controller: controller,
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
              textDirection: TextDirection.ltr,
              style: Theme.of(context).textTheme.headline5,
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
}
