import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_event.dart';
import 'package:mft_customer_side/logic/bloc/plant_type/plant_type_state.dart';
import 'package:mft_customer_side/logic/repo/plant_type/plant_type_repo.dart';

class PlantTypeBloc extends Bloc<PlantTypeEvent, PlantTypeState> {
  final PlantTypeRepo repo;

  PlantTypeBloc({@required this.repo}) : super(PlantTypeInitial());

  @override
  Stream<PlantTypeState> mapEventToState(PlantTypeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetPlantType) {
      yield PlantTypeLoading();

      try {
        final list = await repo.getPlantType();

        yield PlantTypeLoaded(
          plantTypeList: list,
        );
      } catch (_) {
        yield PlantTypeLoading();
      }
    }
  }
}
