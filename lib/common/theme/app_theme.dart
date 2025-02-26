import 'package:flutter/material.dart';
import 'package:mft_customer_side/common/theme/theme_light.dart';

enum AppTheme { lightTheme }

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.lightTheme: CustomTheme.buildTheme(),
};