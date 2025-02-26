import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_state.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserRepo repo;

  UserInfoBloc({@required this.repo}) : super(UserInfoInitial());

  @override
  Stream<UserInfoState> mapEventToState(UserInfoEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetUserInfo) {
      yield UserInfoLoading();

      try {
        final list = await repo.getUserInfo(event.username);

        if (list.result.isNotEmpty) {
          yield UserInfoLoaded(user: list.result[0]);
        } else {
          yield UserInfoLoading();
        }
      } catch (_) {
        yield UserInfoLoading();
      }
    }
  }
}
