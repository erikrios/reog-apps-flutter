import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/food_item.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class FoodsPage extends StatefulWidget {
  @override
  _FoodsPageState createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  List<Article> _articles;

  @override
  Widget build(BuildContext context) {
    if (_articles == null) {
      _articles = List<Article>();
    }

    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.all(3.0),
        itemCount: _articles.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: FoodItem(
                "_articles[index].images[0]", "_articles[index].title"),
            onTap: () async {
              bool result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return DetailsPage(_articles[index], ArticleType.foods);
              }));
              print(result);
            },
          );
        },
      ),
    );
  }
}
