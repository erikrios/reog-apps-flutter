import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/utils/config.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrightnessMenu extends StatefulWidget {
  @override
  _BrightnessMenuState createState() => _BrightnessMenuState();
}

class _BrightnessMenuState extends State<BrightnessMenu> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          currentBrightness.state() ? Icons.wb_sunny : Icons.nights_stay,
          color: Colors.white,
        ),
        onPressed: () async {
          try {
            currentBrightness.switchBrightness();
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setBool(
                DARK_MODE_SHARED_PREFS_KEY, currentBrightness.state());
            setState(() {});
          } catch (err) {
            print(err);
          }
        });
  }
}
