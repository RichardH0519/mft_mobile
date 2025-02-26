import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_event.dart';
import 'package:mft_customer_side/logic/bloc/exchange/request/request_state.dart';
import 'package:mft_customer_side/logic/repo/exchange/exchange_repo.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final ExchangeRepo repo;

  RequestBloc({@required this.repo}) : super(RequestInitial());

  @override
  Stream<RequestState> mapEventToState(RequestEvent event) async* {
    // TODO: implement mapEventToState
    if (event is CreateRequest) {
      yield RequestLoading();

      try {
        final status = await repo.createRequest(
          event.plantTypeID,
          event.weight,
          event.contractID,
          event.username,
        );

        if (status == true) {
          yield RequestCreateSuccess();
        } else {
          yield RequestCreateFail();
        }
      } catch (_) {
        yield RequestCreateFail();
      }
    }

    if (event is EditRequest) {
      yield RequestLoading();

      try {
        final status = await repo.editRequest(
          event.requestID,
          event.weight,
        );

        if (status == true) {
          yield RequestEditSuccess();
        } else {
          yield RequestEditFail();
        }
      } catch (_) {
        yield RequestEditFail();
      }
    }

    if (event is CancelRequest) {
      yield RequestLoading();

      try {
        final status = await repo.cancelRequest(event.requestID);

        if (status == true) {
          yield RequestCancelSuccess();
        } else {
          yield RequestCancelFail();
        }
      } catch (_) {
        yield RequestCancelFail();
      }
    }

    if (event is RejectResponse) {
      yield RequestLoading();

      try {
        final status = await repo.rejectResponse(event.responseID);

        if (status == true) {
          yield ResponseRejectSuccess();
        } else {
          yield ResponseRejectFail();
        }
      } catch (_) {
        yield ResponseRejectFail();
      }
    }

    if (event is GetAllActiveRequest) {
      yield RequestLoading();

      try {
        final list = await repo.getAllActiveRequest(event.username);

        if (list.result.isNotEmpty) {
          yield AllActiveRequestLoaded(requestList: list);
        } else {
          yield RequestListEmpty();
        }
      } catch (_) {
        yield RequestLoading();
      }
    }

    if (event is GetAllActiveRequestByInterest) {
      yield RequestLoading();

      try {
        final list = await repo.getAllActiveRequestByInterest(event.username);

        if (list.result.isNotEmpty) {
          yield AllActiveRequestByInterestLoaded(requestList: list);
        } else {
          yield RequestListEmpty();
        }
      } catch (_) {
        yield RequestLoading();
      }
    }

    if (event is GetRequestByPlantType) {
      yield RequestLoading();

      try {
        final list = await repo.getRequestByPlantType(
          event.username,
          event.plantTypeName,
        );

        if (list.result.isNotEmpty) {
          yield AllRequestByPlantType(requestList: list);
        } else {
          yield RequestListEmpty();
        }
      } catch (_) {
        yield RequestLoading();
      }
    }

    if (event is GetAllResponse) {
      yield RequestLoading();

      try {
        final list = await repo.getAllResponseByRequestID(event.requestID);

        if (list.result.isNotEmpty) {
          yield AllResponseLoaded(responseList: list);
        } else {
          yield RequestListEmpty();
        }
      } catch (_) {
        yield RequestLoading();
      }
    }

    if (event is AcceptExchange) {
      yield RequestLoading();

      try {
        final status =
            await repo.acceptExchange(event.requestID, event.responseID);

        if (status == true) {
          yield AcceptExchangeSuccess();
        } else {
          yield AcceptExchangeFail();
        }
      } catch (_) {
        yield AcceptExchangeFail();
      }
    }

    if (event is GetTreeInfoByRequest) {
      yield RequestLoading();

      try {
        final list = await repo.getTreeInfoByRequest(event.requestID);

        if (list.result.isNotEmpty) {
          yield TreeInfoByRequestLoaded(treeInfo: list.result[0]);
        } else {
          yield RequestListEmpty();
        }
      } catch (_) {
        yield RequestLoading();
      }
    }
  }
}
