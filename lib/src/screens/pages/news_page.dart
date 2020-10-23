import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/news_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/news_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/states/news_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/news_result.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NewsResultBloc>(context);
    if (!(bloc.state is NewsResultSuccessState)) bloc.add(NewsResultFetching());

    return _buildBlocBuilder(bloc);
  }

  Widget _buildBlocBuilder(NewsResultBloc bloc) {
    return BlocBuilder<NewsResultBloc, NewsResultState>(
      cubit: bloc,
      builder: (BuildContext context, NewsResultState state) {
        return state is NewsResultLoadingState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : state is NewsResultErrorState
                ? Center(
                    child: Text(state.error),
                  )
                : _buildNewsResults(
                    (state as NewsResultSuccessState).newsResult);
      },
    );
  }

  Widget _buildNewsResults(NewsResult newsResult) {
    final status = newsResult.status;
    final news = newsResult.data[0];

    return Container(
      child: status.toLowerCase() == 'error'
          ? Center(child: Text(newsResult.message))
          : news.news.isEmpty
              ? Center(
                  child: Text('News is empty.'),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(12.0),
                  itemCount: news.news.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: ArticleItem(
                        image: news.news[index].images.isEmpty? "" : news.news[index].images[0],
                        title: news.news[index].title ?? "",
                        date: news.news[index].date ?? "",
                        description: news.news[index].description ?? "",
                      ),
                      onTap: () {
                        _navigateToDetails(
                          context: context,
                          article: news.news[index]
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
