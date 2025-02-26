import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_rate/contract_rate_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_rate/contract_rate_state.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';

class ContractRateBloc extends Bloc<ContractRateEvent, ContractRateState> {
  final ContractRepo repo;

  ContractRateBloc({@required this.repo}) : super(ContractRateInitial());

  @override
  Stream<ContractRateState> mapEventToState(ContractRateEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetContractRate) {
      yield ContractRateLoading();

      try {
        final list = await repo.getContractRate(
          event.requestID,
        );

        if (list.result.isNotEmpty) {
          yield ContractRateLoaded(
            contractRate: list.result[0],
          );
        } else {
          yield ContractRateLoading();
        }
      } catch (_) {
        yield ContractRateLoading();
      }
    }
  }
}
