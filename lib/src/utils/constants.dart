library constants;

import 'package:shared_preferences/shared_preferences.dart';

const String DARK_MODE_SHARED_PREFS_KEY = 'dark-mode-key';
const String AUTH_TOKEN_SHARED_PREFS_KEY = 'auth-token-key';

getAuthToken() async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString(AUTH_TOKEN_SHARED_PREFS_KEY);
    return token;
  } catch (e) {
    throw e;
  }
}
