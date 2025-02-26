import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/register/register_event.dart';
import 'package:mft_customer_side/logic/bloc/user/register/register_state.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepo repo;

  RegisterBloc({@required this.repo}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // TODO: implement mapEventToState
    if (event is RegisterBtnPressed) {
      yield RegisterLoading();

      try {
        final status = await repo.register(
          event.username,
          event.password,
          event.fullname,
          event.gender,
          event.dateOfBirth,
          event.address,
          event.district,
          event.ward,
          event.phone,
          event.interestTree1,
          event.interestTree2,
          event.interestTree3,
        );

        if (status == true) {
          yield RegisterSuccess();
        } else {
          yield RegisterFail();
        }
      } catch (_) {
        yield RegisterFail();
      }
    }
  }
}
