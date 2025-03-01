import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:mft_customer_side/common/theme/app_theme.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ThemeChangedEvent extends ThemeEvent {
  final AppTheme themeData;

  const ThemeChangedEvent({@required this.themeData})
      : assert(themeData != null, "");

  @override
  // TODO: implement props
  List<Object> get props => [themeData];
}