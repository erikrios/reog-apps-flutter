import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/screens/pages/explore_page.dart';
import 'package:reog_apps_flutter/src/screens/pages/history_page.dart';
import 'package:reog_apps_flutter/src/screens/pages/wallpaper_page.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedTabIndex = 0;

  void onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[ExplorePage(), HistoryPage(), WallpaperPage()];

    final _title = <String>['explore'.tr(), 'history'.tr(), 'wallpaper'.tr()];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: _title[0],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: _title[1],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.wallpaper),
        label: _title[2],
      ),
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: Color(0xff66A84D),
      unselectedItemColor: Color(0x8966A84D),
      type: BottomNavigationBarType.shifting,
      onTap: onNavBarTapped,
    );

    return Scaffold(
      body: Center(
        child: _pages[_selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
