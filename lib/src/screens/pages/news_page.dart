import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/bloc/bloc_provider.dart';
import 'package:reog_apps_flutter/src/bloc/news_result_bloc.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/news.dart';
import 'package:reog_apps_flutter/src/models/news_result.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NewsResultBloc>(context);
    bloc.getNews();
    return _buldStreamBuilder(bloc);
  }

  StreamBuilder _buldStreamBuilder(NewsResultBloc bloc) {
    return StreamBuilder<Response>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final results = NewsResult.fromJson(jsonDecode(snapshot.data.body));
            if (results.status.contains('error')) {
              return Center(
                child: Text(results.message),
              );
            } else if (results.data[0].news.isEmpty) {
              return Center(
                child: Text('News is empty'),
              );
            } else {
              return _buildNewsResults(results.data[0]);
            }
          }
        });
  }

  Container _buildNewsResults(News news) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(12.0),
        itemCount: news.news.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: ArticleItem(
              image: news.news[index].images[0].image,
              title: news.news[index].title,
              date: news.news[index].date,
              description: news.news[index].description,
            ),
            onTap: () {
              _navigateToDetails(
                context: context,
              );
            },
          );
        },
      ),
    );
  }

  void _navigateToDetails(
      {@required BuildContext context, Article article}) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsPage(article);
    }));

    print(result);
  }
}
