import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:reog_apps_flutter/src/bloc/events/news_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/news_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/states/news_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/news.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsResultBloc _bloc;
  int _currentPage = 1;
  int _totalPages = 1;
  final int _limit = 5;
  String status;
  News news;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<NewsResultBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBlocBuilder(_bloc);
  }

  Widget _buildBlocBuilder(NewsResultBloc bloc) {
    return BlocBuilder<NewsResultBloc, NewsResultState>(
        cubit: bloc,
        builder: (BuildContext context, NewsResultState state) {
          if (state is NewsResultInitialState) {
            bloc.add(NewsResultFetching(page: _currentPage, limit: _limit));
            return Container();
          } else if (state is NewsResultLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsResultErrorState) {
            return Center(child: Text(state.error));
          } else {
            return _buildNewsResults(state);
          }
        });
  }

  Widget _buildNewsResults(NewsResultState state) {
    if (state is NewsResultSuccessState) {
      status = state.newsResult.status;
      news = state.newsResult.data[0];
      _currentPage = state.newsResult.data[0].currentPage;
      _totalPages = state.newsResult.data[0].totalPages;
    }
    return Container(
        child: status.toLowerCase() == 'error'
            ? Center(
                child:
                    Text((state as NewsResultSuccessState).newsResult.message))
            : news.news.isEmpty
                ? Center(
                    child: Text('News is empty.'),
                  )
                : LazyLoadScrollView(
                    onEndOfPage: _loadMoreData,
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(12.0),
                          itemCount: news.news.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Material(
                              child: InkWell(
                                child: ArticleItem(
                                  image: news.news[index].images.isEmpty
                                      ? ""
                                      : news.news[index].images[0],
                                  title: news.news[index].title ?? "",
                                  date: news.news[index].date ?? "",
                                  description:
                                      news.news[index].description ?? "",
                                ),
                                onTap: () {
                                  _navigateToDetails(
                                      context: context,
                                      article: news.news[index]);
                                },
                              ),
                            );
                          },
                        ),
                        (state is NewsResultLoadingMoreState)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox()
                      ],
                    ),
                  ));
  }

  void _loadMoreData() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      _bloc.add(NewsResultFetchingMore(page: _currentPage, limit: _limit));
    }
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
