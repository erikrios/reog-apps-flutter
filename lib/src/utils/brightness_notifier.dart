import 'package:flutter/material.dart';

class BrightnessNotifier with ChangeNotifier {
  static bool _isDark = false;

  bool isDark() {
    return _isDark ? true : false;
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
