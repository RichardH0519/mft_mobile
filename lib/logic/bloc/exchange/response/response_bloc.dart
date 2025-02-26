import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/response/response_state.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';

class ResponseBloc extends Bloc<ResponseEvent, ResponseState> {
  final ExchangeRepo repo;

  ResponseBloc({@required this.repo}) : super(ResponseInitial());

  @override
  Stream<ResponseState> mapEventToState(ResponseEvent event) async* {
    // TODO: implement mapEventToState
    if (event is CreateResponse) {
      yield ResponseLoading();

      try {
        final status = await repo.createResponse(
          event.exchangeRequestID,
          event.weight,
          event.contractID,
          event.username,
          event.requestWeight,
        );

        if (status == true) {
          yield ResponseCreateSuccess();
        } else {
          yield ResponseCreateFail();
        }
      } catch (_) {
        yield ResponseCreateFail();
      }
    }

    if (event is EditResponse) {
      yield ResponseLoading();

      try {
        final status = await repo.editResponse(
          event.responseID,
          event.weight,
          event.contractID,
          event.requestWeight,
        );

        if (status == true) {
          yield ResponseEditSuccess();
        } else {
          yield ResponseEditFail();
        }
      } catch (_) {
        yield ResponseEditFail();
      }
    }

    if (event is CancelResponse) {
      yield ResponseLoading();

      try {
        final status = await repo.cancelResponse(
          event.responseID,
        );

        if (status == true) {
          yield ResponseCancelSuccess();
        } else {
          yield ResponseCancelFail();
        }
      } catch (_) {
        yield ResponseCancelFail();
      }
    }

    if (event is GetRequestWeight) {
      yield ResponseLoading();

      try {
        final list = await repo.getRequestWeight(event.responseID);

        if (list.result.isNotEmpty) {
          yield RequestWeightLoaded(request: list.result[0]);
        }
      } catch (_) {
        yield ResponseLoading();
      }
    }
  }
}
