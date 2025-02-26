import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mft_customer_side/common/config/global_translation.dart';
import 'package:mft_customer_side/common/theme/theme_app/theme_bloc.dart';
import 'package:mft_customer_side/common/theme/theme_app/theme_state.dart';
import 'package:mft_customer_side/dependencies.dart';
import 'package:mft_customer_side/logic/api/user/user_api.dart';
import 'package:mft_customer_side/logic/bloc/user/login/login_bloc.dart';
import 'package:mft_customer_side/logic/repo/user/user_repo.dart';
import 'package:mft_customer_side/presentation/screen/login_screen.dart';
import 'package:mft_customer_side/presentation/screen/unauthorized_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final rootFolder = await getApplicationDocumentsDirectory();
  final injector = AppDependencies.initialize(rootFolder.path);
  await injector.get<GlobalTranslation>().init();
  await Firebase.initializeApp();
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //Root of application
  GlobalTranslation translator =
      AppDependencies.injector.get<GlobalTranslation>();

  static final UserRepo repo = UserRepo(
    apiClient: UserAPI(
      httpClient: http.Client(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is LoadedThemeState) {
            return MaterialApp(
              color: Theme.of(context).backgroundColor,
              title: "My Famile Tree",
              theme: state.themeData,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                SfGlobalLocalizations.delegate
              ],
              locale: const Locale("vi"),
              debugShowCheckedModeBanner: false,
              supportedLocales: translator.supportedLocales(),
              initialRoute: '/',
              routes: {
                '/': (context) => UnauthorizedScreen(),
                '/login': (context) => BlocProvider(
                      create: (blocContext) => LoginBloc(repo: repo),
                      child: LoginScreen(),
                    ),
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

/*//for development only
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}*/
