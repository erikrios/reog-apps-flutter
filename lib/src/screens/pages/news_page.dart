import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:reog_apps_flutter/src/bloc/events/news_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/news_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/states/news_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/articles.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsResultBloc _bloc;
  int _currentPage = 1;
  int _totalPages = 1;
  final int _limit = 5;
  Articles news;
  AdmobInterstitial _admobInterstitial;
  final int _interstitialAdFrequency = 2;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<NewsResultBloc>(context);
    _admobInterstitial =
        AdmobInterstitial(adUnitId: 'ca-app-pub-3940256099942544/1033173712');
    _admobInterstitial.load();
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
            return RefreshIndicator(
              onRefresh: () {
                _bloc.add(NewsResultFetching(page: 1, limit: _limit));
                return;
              },
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: Text(state.error)))),
            );
          } else {
            return _buildNewsResults(state);
          }
        });
  }

  Widget _buildNewsResults(NewsResultState state) {
    if (state is NewsResultSuccessState) {
      news = state.newsResult.data[0];
      _currentPage = state.newsResult.data[0].currentPage;
      _totalPages = state.newsResult.data[0].totalPages;
    }

    return Container(
        child: news.articles.isEmpty
            ? Center(
                child: Text('News is empty.'),
              )
            : LazyLoadScrollView(
                onEndOfPage: _loadMoreData,
                child: RefreshIndicator(
                  onRefresh: () {
                    _bloc.add(NewsResultFetching(page: 1, limit: _limit));
                    return;
                  },
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(12.0),
                        itemCount: news.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            child: InkWell(
                              child: ArticleItem(
                                image: news.articles[index].images.isEmpty
                                    ? ""
                                    : news.articles[index].images[0].image,
                                title: news.articles[index].title ?? "",
                                date: news.articles[index].date ?? "",
                                description:
                                    news.articles[index].description ?? "",
                              ),
                              onTap: () async {
                                if (index % _interstitialAdFrequency == 0)
                                  _showAds();
                                _navigateToDetails(
                                    context: context,
                                    article: news.articles[index]);
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
                ),
              ));
  }

  void _loadMoreData() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      _bloc.add(NewsResultFetchingMore(page: _currentPage, limit: _limit));
    }
  }

  void _showAds() async {
    if (await _admobInterstitial.isLoaded) _admobInterstitial.show();
  }

  void _navigateToDetails(
      {@required BuildContext context, Article article}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsPage(article, ArticleType.news);
    })).then((value) => _admobInterstitial.load());
  }
}
