import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract_detail_event.dart';
import 'package:mft_customer_side/logic/bloc/contract_detail/contract_detail_state.dart';
import 'package:mft_customer_side/logic/repo/contract_detail/contract_detail_repo.dart';

class ContractDetailBloc
    extends Bloc<ContractDetailEvent, ContractDetailState> {
  final ContractDetailRepo repo;

  ContractDetailBloc({@required this.repo}) : super(ContractDetailInitial());

  @override
  Stream<ContractDetailState> mapEventToState(
      ContractDetailEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SendDeliveryDate) {
      yield ContractDetailLoading();

      try {
        final status = await repo.sendDeliveryDate(
          event.contractID,
          event.deliveryDate,
        );

        if (status == true) {
          yield SendContractDetailSuccess();
        } else {
          yield SendContractDetailFail();
        }
      } catch (_) {
        yield SendContractDetailFail();
      }
    }

    if (event is GetDates) {
      yield ContractDetailLoading();

      try {
        final list = await repo.getDatesInfo(event.contractID);

        if (list.result.isNotEmpty) {
          yield DatesInfoLoaded(datesInfo: list.result[0]);
        } else {
          yield DatesInfoEmpty();
        }
      } catch (_) {
        yield ContractDetailLoading();
      }
    }

    if (event is GetContractDetails) {
      yield ContractDetailLoading();

      try {
        final list = await repo.getContractDetails(event.contractID);

        if (list.result.isNotEmpty) {
          yield ContractDetailsLoaded(
            contractDetailList: list,
          );
        } else {
          yield ContractDetailsEmpty();
        }
      } catch (_) {
        yield ContractDetailLoading();
      }
    }
  }
}
