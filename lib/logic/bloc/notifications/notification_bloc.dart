import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_state.dart';
import 'package:mft_customer_side/logic/repo/notifications/notification_repo.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo repo;

  NotificationBloc({@required this.repo}) : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    // TODO: implement mapEventToState
    if (event is AddRentNotification) {
      yield NotificationLoading();

      try {
        await repo.addRentNotification(
          event.farmerUsername,
          event.userFullname,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is DeleteContractNotification) {
      yield NotificationLoading();

      try {
        await repo.deleteContractNotification(
          event.farmerUsername,
          event.contractNumber,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is AcceptContractNotification) {
      yield NotificationLoading();

      try {
        await repo.acceptContractNotification(
          event.farmerUsername,
          event.contractNumber,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is CancelContractNotification) {
      yield NotificationLoading();

      try {
        await repo.cancelContractNotification(
          event.farmerUsername,
          event.contractNumber,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is ConfirmCancelContractNotification) {
      yield NotificationLoading();

      try {
        await repo.confirmCancelContractNotification(
          event.farmerUsername,
          event.contractNumber,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is ChooseDeliveryDateNotification) {
      yield NotificationLoading();

      try {
        await repo.chooseDeliveryDateNotification(
          event.farmerUsername,
          event.contractNumber,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is BookVisitNotification) {
      yield NotificationLoading();

      try {
        await repo.bookVisitNotification(
          event.farmerUsername,
          event.customerFullname,
          event.gardenName,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is SendResponseNotification) {
      yield NotificationLoading();

      try {
        await repo.sendResponseNotification(
          event.requestusername,
          event.plantTypename,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is AcceptResponseNotification) {
      yield NotificationLoading();

      try {
        await repo.acceptResponseNotification(
          event.responseUsername,
          event.plantTypename,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is RejectResponseNotification) {
      yield NotificationLoading();

      try {
        await repo.rejectResponseNotification(
          event.responseUsername,
          event.plantTypename,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is ResponseCancelNotification) {
      yield NotificationLoading();

      try {
        await repo.responseCancelNotification(
          event.requestUsername,
          event.plantTypename,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }
    if (event is ResponseConfirmCancelNotification) {
      yield NotificationLoading();

      try {
        await repo.responseConfirmCancelNotification(
          event.requestUsername,
          event.plantTypename,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is RequestCancelNotification) {
      yield NotificationLoading();

      try {
        await repo.requestCancelNotification(
          event.responseUsername,
          event.plantTypename,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }
    if (event is RequestConfirmCancelNotification) {
      yield NotificationLoading();

      try {
        await repo.requestConfirmCancelNotification(
          event.responseUsername,
          event.plantTypename,
        );
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is GetCustomerNotification) {
      yield NotificationLoading();

      try {
        final list = await repo.getNotifications(event.username);

        if (list.isNotEmpty) {
          yield NotificationLoaded(list: list);
        } else {
          yield NotificationEmpty();
        }
      } catch (_) {
        yield NotificationLoading();
      }
    }

    if (event is UpdateCustomerNotification) {
      yield NotificationLoading();

      try {
        await repo.updateNotification(event.username);
      } catch (_) {
        yield NotificationLoading();
      }
    }
  }
}
