import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/screens/foods.dart';
import 'package:reog_apps_flutter/screens/news.dart';
import 'package:reog_apps_flutter/screens/sites.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Explore'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'NEWS',
              ),
              Tab(
                text: 'SITES',
              ),
              Tab(
                text: 'FOODS',
              )
            ],
            indicatorColor: Color(0xffFEDF30),
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        body: TabBarView(children: [
          News(),
          Sites(),
          Foods(),
        ]),
      ),
    );
  }
}
