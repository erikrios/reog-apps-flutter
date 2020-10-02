import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reog Apps'),
      ),
      body: Center(
        child: Text(
          'Hello, World!',
          textAlign: TextAlign.center,
          style: TextStyle(decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
