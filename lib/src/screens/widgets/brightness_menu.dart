import 'package:flutter/material.dart';

class BrightnessMenu extends StatefulWidget {
  final bool _isDarkMode;

  BrightnessMenu(this._isDarkMode);

  @override
  _BrightnessMenuState createState() => _BrightnessMenuState(_isDarkMode);
}

class _BrightnessMenuState extends State<BrightnessMenu> {
  bool _isDarkMode;

  _BrightnessMenuState(this._isDarkMode);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          _isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            _isDarkMode = _isDarkMode ? false : true;
          });
        });
  }
}
