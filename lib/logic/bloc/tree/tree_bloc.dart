import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_event.dart';
import 'package:mft_customer_side/logic/bloc/tree/tree_state.dart';
import 'package:mft_customer_side/logic/repo/tree/tree_repo.dart';

class TreeBloc extends Bloc<TreeEvent, TreeState> {
  final TreeRepo repo;

  TreeBloc({@required this.repo}) : super(TreeInitial());

  @override
  Stream<TreeState> mapEventToState(TreeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllTree) {
      yield TreeLoading();

      try {
        final list = await repo.getAllTree(event.gardenID);

        if (list.result.isNotEmpty) {
          yield TreeLoaded(
            treeList: list,
          );
        } else {
          yield TreeEmpty();
        }
      } catch (_) {
        yield TreeLoading();
      }
    }
  }
}
