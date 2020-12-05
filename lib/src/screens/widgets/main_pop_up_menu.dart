import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/screens/pages/favorites_page.dart';
import 'package:reog_apps_flutter/src/screens/pages/login_page.dart';
import 'package:reog_apps_flutter/src/screens/pages/my_profile_page.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPopUpMenu extends StatelessWidget {
  final bool _isLoggedIn;
  final Function() onBackStack;

  final String savedArticles = 'saved_articles'.tr();
  final String myProfile = 'my_profile'.tr();
  final String logout = 'logout'.tr();
  final String login = 'login'.tr();

  final List<String> _loggedInMenu = new List<String>();
  final List<String> _unloggedInMenu = new List<String>();

  MainPopUpMenu(this._isLoggedIn, {this.onBackStack}) {
    _loggedInMenu.addAll([savedArticles, myProfile, logout]);
    _unloggedInMenu.addAll([savedArticles, login]);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) async {
        if (value == savedArticles) {
          _navigateToFavorite(context);
        } else if (value == login) {
          _navigateToLogin(context);
        } else if (value == myProfile) {
          _navigateToMyProfile(context);
        } else {
          try {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString(AUTH_TOKEN_SHARED_PREFS_KEY, null);
            onBackStack();
          } catch (e) {
            throw e;
          }
        }
      },
      itemBuilder: (context) {
        return (_isLoggedIn ? _loggedInMenu : _unloggedInMenu).map((choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  void _navigateToMyProfile(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyProfilePage();
    }));
  }

  void _navigateToLogin(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    })).then((value) => onBackStack());
  }

  void _navigateToFavorite(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FavoritesPage();
    }));
  }
}
