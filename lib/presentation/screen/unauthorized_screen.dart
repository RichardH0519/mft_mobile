import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/address/district_api.dart';
import 'package:mft_customer_side/logic/api/address/ward_api.dart';
import 'package:mft_customer_side/logic/api/tree_type/tree_type_api.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_bloc.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_event.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_event.dart';
import 'package:mft_customer_side/logic/bloc/user/login/login_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/register/register_bloc.dart';
import 'package:mft_customer_side/logic/repo/address/district_repo.dart';
import 'package:mft_customer_side/logic/repo/address/ward_repo.dart';
import 'package:mft_customer_side/logic/repo/tree_type/tree_type_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/presentation/screen/login_screen.dart';
import 'package:mft_customer_side/presentation/screen/register_screen.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class UnauthorizedScreen extends StatefulWidget {
  @override
  _UnauthorizedScreenState createState() => _UnauthorizedScreenState();
}

class _UnauthorizedScreenState extends BaseState<UnauthorizedScreen> {
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

  static final DistrictRepo districtRepo = DistrictRepo(
    apiClient: DistrictAPI(
      httpClient: http.Client(),
    ),
  );

  static final WardRepo wardRepo = WardRepo(
    apiClient: WardAPI(
      httpClient: http.Client(),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size20,
            ),
            child: Image.asset('assets/images/logo_final.jpg'),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                height: Dimens.loginContainer,
                child: Column(
                  children: [
                    BorderButton(
                      title: translator.text("login"),
                      color: Theme.of(context).primaryColor,
                      function: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builderContext) => BlocProvider(
                              create: (blocContext) => LoginBloc(
                                repo: userRepo,
                              ),
                              child: LoginScreen(),
                            ),
                          ),
                        )
                      },
                    ),
                    _createAccountButton(
                      () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builderContext) => MultiBlocProvider(
                              providers: [
                                BlocProvider<TreeTypeBloc>(
                                  create: (blocContext) => TreeTypeBloc(
                                    repo: treeTypeRepo,
                                  )..add(
                                      GetTreeType(),
                                    ),
                                ),
                                BlocProvider<DistrictBloc>(
                                  create: (blocContext) => DistrictBloc(
                                    repo: districtRepo,
                                  )..add(
                                      GetDistricts(
                                        cityID: 1,
                                      ),
                                    ),
                                ),
                                BlocProvider<WardBloc>(
                                  create: (blocContext) => WardBloc(
                                    repo: wardRepo,
                                  ),
                                ),
                                BlocProvider<RegisterBloc>(
                                  create: (blocContext) => RegisterBloc(
                                    repo: userRepo,
                                  ),
                                ),
                              ],
                              child: RegisterScreen(),
                            ),
                          ),
                        )
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountButton(Function function) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.only(top: Dimens.size15),
        child: Text(
          translator.text("sign_up"),
          style: TextStyle(
            fontSize: Dimens.size18,
          ),
        ),
      ),
    );
  }
}
