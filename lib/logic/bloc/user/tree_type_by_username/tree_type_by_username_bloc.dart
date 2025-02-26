import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/tree_type_by_username/tree_type_by_username_event.dart';
import 'package:mft_customer_side/logic/bloc/user/tree_type_by_username/tree_type_by_username_state.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';

class TreeTypeByUsernameBloc
    extends Bloc<TreeTypeByUsernameEvent, TreeTypeByUsernameState> {
  final UserRepo repo;

  TreeTypeByUsernameBloc({@required this.repo})
      : super(TreeTypeByUsernameInitial());

  @override
  Stream<TreeTypeByUsernameState> mapEventToState(
      TreeTypeByUsernameEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetTreeTypeByUsername) {
      yield TreeTypeByUsernameLoading();

      try {
        final list = await repo.getTreeTypeByUsername(event.username);

        if (list.result.isNotEmpty) {
          yield TreeTypeByUsernameLoaded(
            treeTypeByUsernameList: list,
          );
        } else {
          yield TreeTypeByUsernameEmpty();
        }
      } catch (_) {
        yield TreeTypeByUsernameEmpty();
      }
    }
  }
}
