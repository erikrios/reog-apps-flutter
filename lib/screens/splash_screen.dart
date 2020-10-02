import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Color(0xff97DA7B),
        body: Center(
          child: Text(
            'Hello, World!',
            textAlign: TextAlign.center,
            style: TextStyle(decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
