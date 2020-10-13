import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reog_apps_flutter/src/screens/pages/my_profile_page.dart';

class MainPopUpMenu extends StatelessWidget {
  final bool _isLoggedIn;

  final String savedArticles = 'saved_articles'.tr();
  final String myProfile = 'my_profile'.tr();
  final String logout = 'logout'.tr();
  final String login = 'login'.tr();

  final List<String> _loggedInMenu = new List<String>();
  final List<String> _unloggedInMenu = new List<String>();

  MainPopUpMenu(this._isLoggedIn) {
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
      onSelected: (value) {
        if (value == savedArticles) {
          print(savedArticles);
        } else if (value == login) {
          print(login);
        } else if (value == myProfile) {
          _navigateToMyProfile(context);
        } else {
          print(logout);
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
}
