import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reog Apps',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Center(
        child: Text(
          'Hello, World!',
          textAlign: TextAlign.center,
          style: TextStyle(decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
