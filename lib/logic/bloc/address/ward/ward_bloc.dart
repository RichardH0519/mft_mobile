import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_event.dart';
import 'package:mft_customer_side/logic/bloc/address/ward/ward_state.dart';
import 'package:mft_customer_side/logic/repo/address/ward_repo.dart';

class WardBloc extends Bloc<WardEvent, WardState> {
  final WardRepo repo;

  WardBloc({@required this.repo}) : super(WardInitial());

  @override
  Stream<WardState> mapEventToState(WardEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetWards) {
      yield WardLoading();

      try {
        final list = await repo.getWards(event.districtID);

        yield WardLoaded(
          wardList: list,
        );
      } catch (_) {
        yield WardLoading();
      }
    }
  }
}
