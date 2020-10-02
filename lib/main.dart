import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reog Apps',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SplashScreen(),
    );
  }
}
