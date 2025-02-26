import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/avatar/avatar_event.dart';
import 'package:mft_customer_side/logic/bloc/user/avatar/avatar_state.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final UserRepo repo;

  AvatarBloc({@required this.repo}) : super(AvatarInitial());

  @override
  Stream<AvatarState> mapEventToState(AvatarEvent event) async* {
    // TODO: implement mapEventToState
    if (event is UploadUserAvatar) {
      yield AvatarLoading();
      try {
        final status = await repo.uploadUserAvatar(
          event.username,
          event.image,
        );
        if (status == true) {
          yield UpdateAvatarSuccess();
        } else {
          yield UpdateAvatarFail();
        }
      } catch (_) {
        yield UpdateAvatarFail();
      }
    }

    if (event is RemoveAvatar) {
      yield AvatarLoading();
      try {
        final status = await repo.removeAvatar(
          event.username,
        );
        if (status == true) {
          yield RemoveAvatarSuccess();
        } else {
          yield RemoveAvatarFail();
        }
      } catch (_) {
        yield RemoveAvatarFail();
      }
    }
  }
}
