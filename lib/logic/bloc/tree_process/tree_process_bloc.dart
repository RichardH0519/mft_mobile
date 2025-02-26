import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_process/tree_process_event.dart';
import 'package:mft_customer_side/logic/bloc/tree_process/tree_process_state.dart';
import 'package:mft_customer_side/logic/repo/tree_process/tree_process_repo.dart';

class TreeProcessBloc extends Bloc<TreeProcessEvent, TreeProcessState> {
  final TreeProcessRepo repo;

  TreeProcessBloc({@required this.repo}) : super(TreeProcessInitial());

  @override
  Stream<TreeProcessState> mapEventToState(TreeProcessEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetTreeProcess) {
      yield TreeProcessLoading();

      try {
        final list = await repo.getTreeProcess(event.contractID);

        if (list.result.isNotEmpty) {
          yield TreeProcessLoaded(
            overviewList: list,
          );
        } else {
          yield TreeProcessEmpty();
        }
      } catch (_) {
        yield TreeProcessLoading();
      }
    }
  }
}
