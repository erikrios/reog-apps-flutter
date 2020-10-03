import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/models/article.dart';
import 'package:reog_apps_flutter/screens/widget/sites_item.dart';

class Sites extends StatefulWidget {
  @override
  _SitesState createState() => _SitesState();
}

class _SitesState extends State<Sites> {
  List<Article> _articles;

  @override
  Widget build(BuildContext context) {
    if (_articles == null) {
      _articles = List<Article>();
    }

    setDummyArticles();

    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return SitesItem();
        },
        itemCount: _articles.length,
      ),
    );
  }

  void setDummyArticles() {
    for (int i = 0; i < 19; i++) {
      _articles.add(Article(
          i.toString(),
          'Title $i Lorem ipsum dolor sit amet ipsum dolor sit amet ipsum dolor sit amet',
          '$i Lorem ipsum dolor sit amet ipsum dolor sit amet ipsum dolor sit amet',
          'Sun, $i Oct 20 08:30pm',
          200 + i,
          ['']));
    }
  }
}
