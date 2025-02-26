import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/management/management_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/management/management_state.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';

class ManagementBloc extends Bloc<ManagementEvent, ManagementState> {
  final ExchangeRepo repo;

  ManagementBloc({@required this.repo}) : super(ManagementInitial());

  @override
  Stream<ManagementState> mapEventToState(ManagementEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetExchangeInfoByRequestID) {
      yield ManagementLoading();

      try {
        final list = await repo.getExchangeInfoByRequestID(event.requestID);

        if (list.result.isNotEmpty) {
          yield ExchangeInfoByRequestIDLoaded(
            exchangeInfoList: list,
          );
        } else {
          yield ExchangeInfoByRequestIDEmpty();
        }
      } catch (_) {
        yield ManagementLoading();
      }
    }

    if (event is GetExchangeInfoByResponseID) {
      yield ManagementLoading();

      try {
        final list = await repo.getExchangeInfoByResponseID(event.responseID);

        if (list.result.isNotEmpty) {
          yield ExchangeInfoByResponseIDLoaded(
            exchangeInfo: list.result[0],
          );
        } else {
          yield ExchangeInfoByResponseIDEmpty();
        }
      } catch (_) {
        yield ManagementLoading();
      }
    }

    if (event is FromRequestCancel) {
      yield ManagementLoading();

      try {
        final status = await repo.fromRequestCancel(
          event.managementID,
        );

        if (status == true) {
          yield FromRequestCancelSuccess();
        } else {
          yield FromRequestCancelFail();
        }
      } catch (_) {
        yield ManagementLoading();
      }
    }

    if (event is FromResponseCancel) {
      yield ManagementLoading();

      try {
        final status = await repo.fromResponseCancel(
          event.managementID,
        );

        if (status == true) {
          yield FromResponseCancelSuccess();
        } else {
          yield FromResponseCancelFail();
        }
      } catch (_) {
        yield ManagementLoading();
      }
    }

    if (event is CancelExchange) {
      yield ManagementLoading();

      try {
        final status = await repo.cancelExchange(
          event.requestID,
          event.responseID,
          event.managementID,
        );

        if (status == true) {
          yield CancelExchangeSuccess();
        } else {
          yield CancelExchangeFail();
        }
      } catch (_) {
        yield CancelExchangeFail();
      }
    }
  }
}
