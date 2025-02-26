import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_interest/user_interest_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_interest/user_interest_state.dart';
import 'package:mft_customer_side/logic/repo/user/user_interest_repo.dart';

class UserInterestBloc extends Bloc<UserInterestEvent, UserInterestState> {
  final UserInterestRepo repo;

  UserInterestBloc({@required this.repo}) : super(UserInterestInitial());

  @override
  Stream<UserInterestState> mapEventToState(UserInterestEvent event) async* {
    // TODO: implement mapEventToState
    if (event is InterestDeleteBtnPressed) {
      yield UserInterestLoading();

      try {
        final status = await repo.deleteInterest(event.id);

        if (status == true) {
          yield UserInterestDeleteSuccess();
        } else {
          yield UserInterestDeleteFail();
        }
      } catch (_) {
        yield UserInterestLoading();
      }
    }

    if (event is InterestUpdateBtnPressed) {
      yield UserInterestLoading();

      try {
        final status = await repo.updateInterest(
          event.id,
          event.username,
          event.treeTypeID,
        );

        if (status == true) {
          yield UserInterestUpdateSuccess();
        } else {
          yield UserInterestUpdateFail();
        }
      } catch (_) {
        yield UserInterestLoading();
      }
    }
  }
}
