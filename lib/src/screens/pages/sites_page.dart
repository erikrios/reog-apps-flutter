import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/sites_item.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class SitesPage extends StatefulWidget {
  @override
  _SitesPageState createState() => _SitesPageState();
}

class _SitesPageState extends State<SitesPage> {
  List<Article> _articles;

  @override
  Widget build(BuildContext context) {
    if (_articles == null) {
      _articles = List<Article>();
    }

    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(0.0),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child:
                SitesItem("_articles[index].images[0]", _articles[index].title),
            onTap: () async {
              bool result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return DetailsPage(_articles[index], ArticleType.sites);
              }));
              print(result);
            },
          );
        },
        itemCount: _articles.length,
      ),
    );
  }
}
