import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/api/address/district_api.dart';
import 'package:mft_customer_side/logic/api/address/ward_api.dart';
import 'package:mft_customer_side/logic/api/block/block_api.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_bloc.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_event.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_bloc.dart';
import 'package:mft_customer_side/logic/bloc/block/block_bloc.dart';
import 'package:mft_customer_side/logic/bloc/block/block_event.dart';
import 'package:mft_customer_side/logic/bloc/user/avatar/avatar_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/edit/edit_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_state.dart';
import 'package:mft_customer_side/logic/repo/address/district_repo.dart';
import 'package:mft_customer_side/logic/repo/address/ward_repo.dart';
import 'package:mft_customer_side/logic/repo/block/block_repo.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/screen/block_list_screen.dart';
import 'package:mft_customer_side/presentation/screen/profile_detail_screen.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';
import 'package:mft_customer_side/presentation/widget/profile_screen/avatar_dialog.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({@required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(user: user);
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
  static final UserRepo repo = UserRepo(
    apiClient: UserAPI(
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

  static final BlockRepo blockRepo = BlockRepo(
    apiClient: BlockAPI(
      httpClient: http.Client(),
    ),
  );

  final User user;

  _ProfileScreenState({@required this.user});

  String avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size35,
            ),
            child: BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if (state is UserInfoLoaded) {
                  avatar = state.user.avatar;
                }

                return CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  backgroundImage: avatar != null ? NetworkImage(avatar) : null,
                  child: Stack(
                    children: [
                      avatar == null
                          ? Icon(
                              Icons.person,
                              size: Dimens.size140,
                            )
                          : Container(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (builderContext) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (blocContext) => AvatarBloc(
                                      repo: repo,
                                    ),
                                  ),
                                ],
                                child: AvatarDialog(
                                  username: user.username,
                                  avatar: avatar,
                                ),
                              ),
                            ).then(
                              (value) {
                                BlocProvider.of<UserInfoBloc>(context).add(
                                  GetUserInfo(
                                    username: user.username,
                                  ),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            radius: Dimens.size18,
                            backgroundColor: Colors.white70,
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  radius: Dimens.size70,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimens.size10),
            child: BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if (state is UserInfoLoaded) {
                  return Text(
                    state.user.fullname,
                    style: TextStyle(
                      fontSize: Dimens.size25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimens.size50),
            child: _userInteractRow(
              label: translator.text("user_edit_profile"),
              icon: Icons.edit,
              function: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builderContext) => MultiBlocProvider(
                      providers: [
                        //get user info
                        BlocProvider<UserInfoBloc>(
                          create: (blocContext) => UserInfoBloc(
                            repo: repo,
                          )..add(
                              GetUserInfo(
                                username: user.username,
                              ),
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
                        BlocProvider<EditBloc>(
                          create: (blocContext) => EditBloc(
                            repo: repo,
                          ),
                        ),
                      ],
                      child: ProfileDetailScreen(),
                    ),
                  ),
                ).then((value) {
                  BlocProvider.of<UserInfoBloc>(context).add(
                    GetUserInfo(
                      username: user.username,
                    ),
                  );
                }),
              }, // go to profile detail
            ),
          ),
          _userInteractRow(
            label: translator.text("block_list"),
            icon: Icons.list,
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builderContext) => MultiBlocProvider(
                    providers: [
                      BlocProvider<BlockBloc>(
                        create: (blocContext) => BlockBloc(
                          repo: blockRepo,
                        )..add(
                            GetBlockedList(
                              username: user.username,
                            ),
                          ),
                      ),
                    ],
                    child: BlockListScreen(),
                  ),
                ),
              );
            }, //go to app info
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.center,
              child: Padding(
                padding: const EdgeInsets.only(top: Dimens.size15),
                child: BorderButton(
                  title: translator.text("logout"),
                  color: Theme.of(context).errorColor,
                  function: _showLogoutDialog,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userInteractRow({String label, IconData icon, Function function}) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.only(
          top: Dimens.size20,
          bottom: Dimens.size20,
          left: Dimens.size15,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.all(width: Dimens.thick02),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: Dimens.size5),
              child: Icon(
                icon,
                color: Colors.green,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: Dimens.size18,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (builderContext) {
        return AlertDialog(
          title: Text(
            translator.text("logout"),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  translator.text("logout_alert_1"),
                ),
                Text(
                  translator.text("logout_alert_2"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
              },
              child: Text(
                translator.text("declined"),
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                SystemNavigator.pop(),
              },
              child: Text(
                translator.text("approved"),
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
