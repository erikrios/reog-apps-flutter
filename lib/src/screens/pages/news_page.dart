import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> _articles;

  @override
  Widget build(BuildContext context) {
    if (_articles == null) {
      _articles = List<Article>();
    }

    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(12.0),
        itemCount: _articles.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: ArticleItem(
                "_articles[index].images[0]",
                _articles[index].title,
                _articles[index].description,
                _articles[index].date),
            onTap: () {
              _navigateToDetails(_articles[index]);
            },
          );
        },
      ),
    );
  }

  void _navigateToDetails(Article article) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsPage(article);
    }));

    print(result);
  }
}
