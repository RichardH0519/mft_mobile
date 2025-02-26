import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_state.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractRepo repo;

  ContractBloc({@required this.repo}) : super(ContractInitial());

  @override
  Stream<ContractState> mapEventToState(ContractEvent event) async* {
    // TODO: implement mapEventToState
    if (event is AddContract) {
      yield ContractLoading();

      try {
        final status = await repo.addNewContract(
          event.treeID,
          event.customerUsername,
          event.farmerUsername,
          event.numOfYear,
          event.totalPrice,
          event.totalYield,
          event.totalCrop,
          event.shipFee,
        );

        if (status == true) {
          yield ContractAddedSuccess();
        } else {
          yield ContractAddedFail();
        }
      } catch (_) {
        yield ContractAddedFail();
      }
    }

    if (event is AcceptContract) {
      yield ContractLoading();

      try {
        final status = await repo.acceptContract(
          event.treeID,
          event.contractID,
        );

        if (status == true) {
          yield ContractAcceptSuccess();
        } else {
          yield ContractAcceptFail();
        }
      } catch (_) {
        yield ContractAcceptFail();
      }
    }

    if (event is CancelContract) {
      yield ContractLoading();

      try {
        final status = await repo.cancelContract(event.contractID);

        if (status == true) {
          yield ContractCancelSuccess();
        } else {
          yield ContractCancelFail();
        }
      } catch (_) {
        yield ContractCancelFail();
      }
    }

    if (event is DeleteContractRequest) {
      yield ContractLoading();

      try {
        final status = await repo.deleteContractRequest(event.contractID);

        if (status == true) {
          yield ContractDeleteSuccess();
        } else {
          yield ContractDeleteFail();
        }
      } catch (_) {
        yield ContractDeleteFail();
      }
    }

    if (event is SendCancelContract) {
      yield ContractLoading();

      try {
        final status = await repo.sendCancelContract(
          event.contractID,
          event.cancelParty,
          event.cancelReason,
          event.refund,
        );

        if (status == true) {
          yield ContractSendCancelSuccess();
        } else {
          yield ContractSendCancelFail();
        }
      } catch (_) {
        yield ContractSendCancelFail();
      }
    }

    if (event is GetContractOverviews) {
      yield ContractLoading();

      try {
        final list = await repo.getContractOverviews(event.username);

        if (list.result.isNotEmpty) {
          yield ContractOverviewsLoaded(contractOverviewList: list);
        } else {
          yield ContractOverviewsEmpty();
        }
      } catch (_) {
        yield ContractLoading();
      }
    }

    if (event is GetContractByTreeID) {
      yield ContractLoading();

      try {
        final list = await repo.getContractByTreeID(event.treeID);

        if (list.result.isNotEmpty) {
          yield ContractLoaded(contract: list.result[0]);
        } else {
          yield ContractLoading();
        }
      } catch (_) {
        yield ContractLoading();
      }
    }

    if (event is GetContractCancelInfo) {
      yield ContractLoading();

      try {
        final list = await repo.getCancelInfo(event.contractID);

        if (list.result.isNotEmpty) {
          yield CancelInfoLoaded(cancelInfo: list.result[0]);
        } else {
          yield ContractLoading();
        }
      } catch (_) {
        yield ContractLoading();
      }
    }
  }
}
