import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/screens/explore.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedTabIndex = 0;

  void onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[
      Explore(),
      Text('History Widget'),
      Text('Wallpaper Widget'),
    ];

    final _title = <String>['Explore', 'History', 'Wallpaper'];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        title: Text(_title[0]),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        title: Text(_title[1]),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.wallpaper),
        title: Text(_title[2]),
      ),
    ];

    final _bottomNavBar = Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xffCAFFAB)),
        child: BottomNavigationBar(
          items: _bottomNavBarItems,
          currentIndex: _selectedTabIndex,
          selectedItemColor: Color(0xff66A84D),
          unselectedItemColor: Color(0x8966A84D),
          type: BottomNavigationBarType.shifting,
          onTap: onNavBarTapped,
        ));

    return Scaffold(
      body: Center(
        child: _pages[_selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
