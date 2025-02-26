import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/package/package_event.dart';
import 'package:mft_customer_side/logic/bloc/package/package_state.dart';
import 'package:mft_customer_side/logic/repo/package/package_repo.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  final PackageRepo repo;

  PackageBloc({@required this.repo}) : super(PackageInitial());

  @override
  Stream<PackageState> mapEventToState(PackageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetYield) {
      yield PackageLoading();

      try {
        final list = await repo.getYield(
          event.username,
          event.contractID,
        );

        if (list.result.isNotEmpty) {
          yield YieldLoaded(
            yields: list.result[0],
          );
        } else {
          yield PackageLoading();
        }
      } catch (_) {
        yield PackageLoading();
      }
    }

    if (event is GetDeliverySchedule) {
      yield PackageLoading();

      try {
        final list = await repo.getDeliverySchedule(event.username);

        if (list.result.isNotEmpty) {
          yield DeliveryScheduleLoaded(
            deliveryList: list,
          );
        } else {
          yield DeliveryScheduleEmpty();
        }
      } catch (_) {
        yield PackageLoading();
      }
    }
  }
}
