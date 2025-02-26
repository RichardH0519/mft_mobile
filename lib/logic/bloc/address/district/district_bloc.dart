import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_event.dart';
import 'package:mft_customer_side/logic/bloc/address/district/district_state.dart';
import 'package:mft_customer_side/logic/repo/address/district_repo.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final DistrictRepo repo;

  DistrictBloc({@required this.repo}) : super(DistrictInitial());

  @override
  Stream<DistrictState> mapEventToState(DistrictEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetDistricts) {
      yield DistrictLoading();

      try {
        final list = await repo.getDistricts(event.cityID);

        yield DistrictLoaded(
          districtList: list,
        );
      } catch (_) {
        yield DistrictLoading();
      }
    }
  }
}
