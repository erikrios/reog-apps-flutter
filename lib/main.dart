import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:reog_apps_flutter/src/bloc/foods_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/histories_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/news_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/sites_result_bloc.dart';
import 'package:reog_apps_flutter/src/screens/pages/splash_screen_page.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/utils/constants.dart' as Constants;

Future main() async {
  await DotEnv().load('.env');
  _setupLogging();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: <Locale>[
      Locale('en'),
      Locale('en', 'US'),
      Locale('id', 'ID'),
      Locale('hi', 'IN'),
      Locale('es', 'ES'),
      Locale('ru', 'RU'),
      Locale('vi', 'VN'),
      Locale('pt', 'PT'),
      Locale('af', 'ZA'),
      Locale('ar', 'AR'),
      Locale('bn', 'IN'),
      Locale('cs', 'CZ'),
      Locale('fr', 'FR'),
      Locale('ja', 'JP'),
      Locale('ms', 'MY'),
      Locale('zh', 'CN')
    ],
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
  ));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;

  @override
  void initState() {
    super.initState();

    currentBrightness.addListener(() {
      setState(() {});
    });

    _getIsDarkMode().then((value) {
      setState(() {
        currentBrightness.setBrightness(value);
      });
    });

    _getAuthToken().then((value) {
      token = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsResultBloc>(
          create: (BuildContext context) => NewsResultBloc(
              service: ReogAppsService.create(authTokenValue: token)),
        ),
        BlocProvider<SitesResultBloc>(
          create: (BuildContext context) => SitesResultBloc(
              service: ReogAppsService.create(authTokenValue: token)),
        ),
        BlocProvider<FoodsResultBloc>(
          create: (BuildContext context) => FoodsResultBloc(
              service: ReogAppsService.create(authTokenValue: token)),
        ),
        BlocProvider<HistoriesResultBloc>(
          create: (BuildContext context) => HistoriesResultBloc(
              service: ReogAppsService.create(authTokenValue: token)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app_name'.tr(),
        theme: ThemeData(
          brightness: currentBrightness.isDark(),
          primarySwatch: MaterialColor(0xff97DA7B, swatch),
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: SplashScreenPage(),
      ),
    );
  }

  _getIsDarkMode() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isDarkMode =
          preferences.getBool(Constants.DARK_MODE_SHARED_PREFS_KEY);
      return isDarkMode != null ? isDarkMode : false;
    } catch (err) {
      throw err;
    }
  }

  _getAuthToken() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token =
          preferences.getString(Constants.AUTH_TOKEN_SHARED_PREFS_KEY);
      return token;
    } catch (err) {
      throw err;
    }
  }
}

Map<int, Color> swatch = {
  50: Color.fromRGBO(151, 218, 123, .1),
  100: Color.fromRGBO(151, 218, 123, .2),
  200: Color.fromRGBO(151, 218, 123, .3),
  300: Color.fromRGBO(151, 218, 123, .4),
  400: Color.fromRGBO(151, 218, 123, .5),
  500: Color.fromRGBO(151, 218, 123, .6),
  600: Color.fromRGBO(151, 218, 123, .7),
  700: Color.fromRGBO(151, 218, 123, .8),
  800: Color.fromRGBO(151, 218, 123, .9),
  900: Color.fromRGBO(151, 218, 123, 1),
};
