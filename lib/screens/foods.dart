import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/models/article.dart';
import 'package:reog_apps_flutter/screens/widget/food_item.dart';

class Foods extends StatefulWidget {
  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  List<Article> _articles;

  @override
  Widget build(BuildContext context) {
    if (_articles == null) {
      _articles = List<Article>();
    }

    setDummyArticles();

    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.all(3.0),
        itemCount: _articles.length,
        itemBuilder: (BuildContext context, int index) {
          return FoodItem();
        },
      ),
    );
  }

  void setDummyArticles() {
    for (int i = 0; i < 20; i++) {
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
