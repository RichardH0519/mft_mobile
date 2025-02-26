import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_state.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';

class TreeInfoBloc extends Bloc<TreeInfoEvent, TreeInfoState> {
  final ContractRepo repo;

  TreeInfoBloc({@required this.repo}) : super(TreeInfoInitial());

  @override
  Stream<TreeInfoState> mapEventToState(TreeInfoEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetTreeInfo) {
      yield TreeInfoLoading();

      try {
        final tree = await repo.getTreeInfo(event.treeID);

        if (tree.result.isNotEmpty) {
          yield TreeInfoLoaded(tree: tree.result[0]);
        } else {
          yield TreeInfoLoading();
        }
      } catch (_) {
        yield TreeInfoLoading();
      }
    }
  }
}
