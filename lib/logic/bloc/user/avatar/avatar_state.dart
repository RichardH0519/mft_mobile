import 'package:equatable/equatable.dart';

abstract class AvatarState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AvatarInitial extends AvatarState {}

class AvatarLoading extends AvatarState {}

class RemoveAvatarSuccess extends AvatarState {}

class RemoveAvatarFail extends AvatarState {}

class UpdateAvatarSuccess extends AvatarState {}

class UpdateAvatarFail extends AvatarState {}