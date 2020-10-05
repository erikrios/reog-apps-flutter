import 'package:flutter/material.dart';

class MainPopUpMenu extends StatelessWidget {
  final bool _isLoggedIn;
  final List<String> _loggedInMenu = [
    'Saved Articles',
    'My Profile',
    'Log Out'
  ];
  final List<String> _unloggedInMenu = ['Saved Articles', 'Login'];

  MainPopUpMenu(this._isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        switch (value) {
          case 'Saved Articles':
            {
              print('Saved Articles');
            }
            break;
          case 'Login':
            {
              print('Login');
            }
            break;
          case 'My Profile':
            {
              print('My Profile');
            }
            break;
          case 'Log Out':
            {
              print('Log Out');
            }
            break;
          default:
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
}
