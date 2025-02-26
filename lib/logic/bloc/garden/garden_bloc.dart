import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_event.dart';
import 'package:mft_customer_side/logic/bloc/garden/garden_state.dart';
import 'package:mft_customer_side/logic/repo/garden/garden_repo.dart';

class GardenBloc extends Bloc<GardenEvent, GardenState> {
  final GardenRepo repo;

  GardenBloc({@required this.repo}) : super(GardenInitial());

  @override
  Stream<GardenState> mapEventToState(GardenEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllGarden) {
      yield GardenLoading();

      try {
        final list = await repo.getAllActiveGarden();

        if (list.result.isNotEmpty) {
          yield GardenLoaded(
            gardenList: list,
          );
        } else {
          yield GardenEmpty();
        }
      } catch (_) {
        yield GardenLoading();
      }
    }

    if (event is GetAllGardenByInterest) {
      yield GardenLoading();

      try {
        final list = await repo.getAllActiveGardenByInteret(event.username);

        if (list.result.isNotEmpty) {
          yield GardenByInterestLoaded(
            gardenList: list,
          );
        } else {
          yield GardenEmpty();
        }
      } catch (_) {
        yield GardenLoading();
      }
    }

    if (event is GetAllGardenByPlantType) {
      yield GardenLoading();

      try {
        final list =
            await repo.getAllActiveGardenByPlantType(event.plantTypeName);

        if (list.result.isNotEmpty) {
          yield GardenByPlantTypeLoaded(
            gardenList: list,
          );
        } else {
          yield GardenEmpty();
        }
      } catch (_) {
        yield GardenLoading();
      }
    }
  }
}
