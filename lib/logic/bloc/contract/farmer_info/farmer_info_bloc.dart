import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_state.dart';
import 'package:mft_customer_side/logic/repo/contract/contract_repo.dart';

class FarmerInfoBloc extends Bloc<FarmerInfoEvent, FarmerInfoState> {
  final ContractRepo repo;

  FarmerInfoBloc({@required this.repo}) : super(FarmerInfoInitial());

  @override
  Stream<FarmerInfoState> mapEventToState(FarmerInfoEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetFarmerInfo) {
      yield FarmerInfoLoading();

      try {
        final user = await repo.getFarmerInfo(event.treeID);

        if (user.result.isNotEmpty) {
          yield FarmerInfoLoaded(user: user.result[0]);
        } else {
          yield FarmerInfoLoading();
        }
      } catch (_) {
        yield FarmerInfoLoading();
      }
    }
  }
}
