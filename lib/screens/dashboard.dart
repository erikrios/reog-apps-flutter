import 'package:flutter/material.dart';

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
      Text('Explore Widget'),
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

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: Color(0xff66A84D),
      unselectedItemColor: Color(0x8966A84D),
      backgroundColor: Color(0xffCAFFAB),
      onTap: onNavBarTapped,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_selectedTabIndex]),
      ),
      body: Center(
        child: _pages[_selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
