import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/theme/app_theme.dart';
import 'package:mft_customer_side/common/theme/theme_app/theme_event.dart';
import 'package:mft_customer_side/common/theme/theme_app/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(LoadedThemeState(themeData: appThemeData[AppTheme.lightTheme]));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is ThemeChangedEvent) {
      yield LoadedThemeState(themeData: appThemeData[event.themeData]);
    }
  }
}
