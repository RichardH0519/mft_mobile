import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/login/login_event.dart';
import 'package:mft_customer_side/logic/bloc/user/login/login_state.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepo repo;

  LoginBloc({@required this.repo}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoginBtnPressed) {
      yield LoginLoading();

      try {
        final user = await repo.login(event.username, event.password);

        if (user.result.isNotEmpty) {
          yield LoginSuccess(user: user.result[0]);
        } else {
          yield LoginFail();
        }
      } catch (_) {
        yield LoginFail();
      }
    }
  }
}
