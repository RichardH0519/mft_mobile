import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/block/block_event.dart';
import 'package:mft_customer_side/logic/bloc/block/block_state.dart';
import 'package:mft_customer_side/logic/repo/block/block_repo.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  final BlockRepo repo;

  BlockBloc({@required this.repo}) : super(BlockInitial());

  @override
  Stream<BlockState> mapEventToState(BlockEvent event) async* {
    // TODO: implement mapEventToState
    if (event is BlockPressed) {
      yield BlockLoading();

      try {
        final status = await repo.block(
          event.username,
          event.blocked,
        );

        if (status == true) {
          yield BlockSuccess();
        } else {
          yield BlockFail();
        }
      } catch (_) {
        yield BlockFail();
      }
    }

    if (event is Unblock) {
      yield BlockLoading();

      try {
        final status = await repo.unblock(event.id);

        if (status == true) {
          yield UnblockSuccess();
        } else {
          yield UnblockFail();
        }
      } catch (_) {
        yield UnblockFail();
      }
    }

    if (event is GetBlockedList) {
      yield BlockLoading();

      try {
        final list = await repo.getBlockedList(event.username);

        if (list.result.isNotEmpty) {
          yield BlockedListLoaded(blockedList: list);
        } else {
          yield BlockedListEmpty();
        }
      } catch (_) {
        yield BlockLoading();
      }
    }
  }
}
