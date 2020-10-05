import 'package:flutter/material.dart';

class BrightnessNotifier with ChangeNotifier {
  static bool _isDark = false;

  Brightness isDark() {
    return _isDark ? Brightness.dark : Brightness.light;
  }

  bool state() {
    return _isDark;
  }

  void setBrightness(bool isDark) {
    _isDark = isDark;
    notifyListeners();
  }

  void switchBrightness() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
