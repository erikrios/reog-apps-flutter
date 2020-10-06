import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/screens/pages/splash_screen_page.dart';
import 'src/utils/constants.dart' as Constants;

void main() {
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: <Locale>[
      Locale('en'),
      Locale('en', 'US'),
      Locale('id', 'ID'),
      Locale('hi', 'IN'),
      Locale('es', 'ES'),
      Locale('ru', 'RU'),
      Locale('vi', 'VN')
    ],
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reog Apps',
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
    );
  }

  _getIsDarkMode() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isDarkMode =
          preferences.getBool(Constants.DARK_MODE_SHARED_PREFS_KEY);
      return isDarkMode != null ? isDarkMode : false;
    } catch (err) {
      print(err);
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
