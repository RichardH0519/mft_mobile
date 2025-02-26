import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/edit/edit_event.dart';
import 'package:mft_customer_side/logic/bloc/user/edit/edit_state.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final UserRepo repo;

  EditBloc({@required this.repo}) : super(EditInitial());

  @override
  Stream<EditState> mapEventToState(EditEvent event) async* {
    // TODO: implement mapEventToState
    if (event is EditBtnPressed) {
      yield EditLoading();

      try {
        final status = await repo.edit(
          event.username,
          event.password,
          event.fullname,
          event.gender,
          event.dateOfBirth,
          event.address,
          event.district,
          event.ward,
          event.phone,
          event.email,
        );

        if (status == true) {
          yield EditSuccess();
        } else {
          yield EditFail();
        }
      } catch (_) {
        yield EditFail();
      }
    }
  }
}
