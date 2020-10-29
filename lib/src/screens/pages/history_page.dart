import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';
import 'package:reog_apps_flutter/src/screens/widgets/brightness_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ScrollController _scrollViewController;
  List<Article> _articles;

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
    if (_articles == null) {
      _articles = List<Article>();
    }

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('history'.tr()),
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              actions: <Widget>[
                BrightnessMenu(),
                MainPopUpMenu(false),
              ],
            ),
          ];
        },
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: ArticleItem(),
              onTap: () async {
                bool result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return DetailsPage(_articles[index], ArticleType.history);
                }));
                print(result);
              },
            );
          },
          itemCount: _articles.length,
          padding: EdgeInsets.all(12.0),
        ),
      ),
    );
  }
}
