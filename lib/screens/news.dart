import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/models/article.dart';

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
      color: Color(0xffEFF4ED),
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
              ),
              title: Text(
                articles[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(articles[index].description),
            ),
          );
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
