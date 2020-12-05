import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/screens/pages/foods_page.dart';
import 'package:reog_apps_flutter/src/screens/pages/news_page.dart';
import 'package:reog_apps_flutter/src/screens/pages/sites_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/brightness_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
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
    final newsPage = NewsPage();
    final sitesPage = SitesPage();
    final foodsPage = FoodsPage();

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('explore'.tr()),
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              actions: <Widget>[
                BrightnessMenu(),
                MainPopUpMenu(getAuthToken()
                    .then((value) => value == null ? false : true)),
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    text: 'news'.tr().toUpperCase(),
                  ),
                  Tab(
                    text: 'sites'.tr().toUpperCase(),
                  ),
                  Tab(
                    text: 'foods'.tr().toUpperCase(),
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
            newsPage,
            sitesPage,
            foodsPage,
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
