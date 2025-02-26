import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/tabs/tabs_state.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  final ExchangeRepo repo;

  TabsBloc({@required this.repo}) : super(TabsInitial());

  @override
  Stream<TabsState> mapEventToState(TabsEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetRequestByUsername) {
      yield TabsLoading();

      try {
        final list = await repo.getAllRequestByUsername(event.username);

        if (list.result.isNotEmpty) {
          yield RequestListLoaded(requestList: list);
        } else {
          yield ListEmpty();
        }
      } catch (_) {
        yield TabsLoading();
      }
    }

    if (event is GetResponseByUsername) {
      yield TabsLoading();

      try {
        final list = await repo.getAllResponseByUsername(event.username);

        if (list.result.isNotEmpty) {
          yield ResponseListLoaded(responseList: list);
        } else {
          yield ListEmpty();
        }
      } catch (_) {
        yield TabsLoading();
      }
    }
  }
}
