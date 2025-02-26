import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_event.dart';
import 'package:mft_customer_side/logic/bloc/tree_type/tree_type_state.dart';
import 'package:mft_customer_side/logic/repo/tree_type/tree_type_repo.dart';

class TreeTypeBloc extends Bloc<TreeTypeEvent, TreeTypeState> {
  final TreeTypeRepo repo;

  TreeTypeBloc({@required this.repo}) : super(TreeTypeInitial());

  @override
  Stream<TreeTypeState> mapEventToState(TreeTypeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetTreeType) {
      yield TreeTypeLoading();

      try {
        final list = await repo.getTreeType();

        yield TreeTypeLoaded(
          treeTypeList: list,
        );
      } catch (_) {
        yield TreeTypeLoading();
      }
    }
  }
}
