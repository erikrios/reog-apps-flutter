import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/screens/foods.dart';
import 'package:reog_apps_flutter/screens/news.dart';
import 'package:reog_apps_flutter/screens/sites.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Explore'),
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
                tabs: <Widget>[
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
          ];
        },
        body: TabBarView(
          children: [
            News(),
            Sites(),
            Foods(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
