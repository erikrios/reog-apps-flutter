import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/models/article.dart';
import 'package:reog_apps_flutter/screens/widget/article_item.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<Article> articles;

  @override
  Widget build(BuildContext context) {
    if (articles == null) {
      articles = List<Article>();
    }

    setDummyArticles();

    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(12.0),
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return ArticleItem();
        },
      ),
    );
  }

  void setDummyArticles() {
    for (int i = 0; i < 20; i++) {
      articles.add(Article(
          i.toString(),
          'Title $i',
          '$i Lorem ipsum dolor sit amet ipsum dolor sit amet ipsum dolor sit amet',
          'Sun, $i Oct 20 08:30pm',
          200 + i,
          ['']));
    }
  }
}
