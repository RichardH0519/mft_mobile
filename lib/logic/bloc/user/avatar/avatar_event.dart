import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AvatarEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UploadUserAvatar extends AvatarEvent {
  final String username;
  final File image;

  UploadUserAvatar({@required this.username, @required this.image});

  @override
  // TODO: implement props
  List<Object> get props => [
        image,
      ];
}

class RemoveAvatar extends AvatarEvent {
  final String username;

  RemoveAvatar({@required this.username});

  @override
  // TODO: implement props
  List<Object> get props => [
        username,
      ];
}
