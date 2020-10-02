import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reog Apps',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff97DA7B, swatch),
        canvasColor: Color(0xffEFF4ED),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: SplashScreen(),
    );
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
