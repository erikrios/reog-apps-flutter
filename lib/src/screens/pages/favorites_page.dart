import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';
import 'package:reog_apps_flutter/src/screens/widgets/brightness_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
  }


  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget
          >[
          SliverAppBar(
          title: Text('Favorites'),
          floating: true,
          snap: true,
          forceElevated: innerBoxIsScrolled,
          actions: [
          BrightnessMenu(),
          MainPopUpMenu(true),
          ],
          )
          ];
        },
        body: LazyLoadScrollView(
          onEndOfPage: null,
          child: ListView.builder(shrinkWrap: true,
              padding: EdgeInsets.all(12.0),
              itemCount: null,
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  child: InkWell(
                    child: ArticleItem(
                      image: null,
                      title: null,
                      date: null,
                      description: null,
                    ),
                    onTap: () {},
                  ),
                );
              }),
        ),
      ),
    );
  }
}
