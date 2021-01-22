import 'package:admob_flutter/admob_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:reog_apps_flutter/src/bloc/events/histories_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/histories_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/states/histories_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/articles.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';
import 'package:reog_apps_flutter/src/screens/widgets/brightness_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ScrollController _scrollViewController;
  HistoriesResultBloc _bloc;
  int _currentPage = 1;
  int _totalPage = 1;
  final int _limit = 5;
  Articles histories;
  bool _isLoggedIn;
  AdmobInterstitial _admobInterstitial;
  final int _interstitialAdFrequency = 2;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _bloc = BlocProvider.of<HistoriesResultBloc>(context);
    getAuthToken().then((value) {
      setState(() {
        _isLoggedIn = value == null ? false : true;
      });
    });
    _admobInterstitial =
        AdmobInterstitial(adUnitId: 'ca-app-pub-3940256099942544/1033173712');
    _admobInterstitial.load();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('history'.tr()),
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              actions: <Widget>[
                BrightnessMenu(),
                MainPopUpMenu(
                  _isLoggedIn,
                  onBackStack: () {
                    getAuthToken().then((value) {
                      setState(() {
                        _isLoggedIn = value == null ? false : true;
                      });
                    });
                  },
                ),
              ],
            ),
          ];
        },
        body: _buildBlocBuilder(_bloc),
      ),
    );
  }

  Widget _buildBlocBuilder(HistoriesResultBloc bloc) {
    return BlocBuilder<HistoriesResultBloc, HistoriesResultState>(
      cubit: bloc,
      builder: (BuildContext context, HistoriesResultState state) {
        if (state is HistoriesResultInitialState) {
          bloc.add(HistoriesResultFetching(page: _currentPage, limit: _limit));
          return Container();
        } else if (state is HistoriesResultLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HistoriesResultErrorSState) {
          return RefreshIndicator(
            onRefresh: () {
              bloc.add(HistoriesResultFetching(page: 1, limit: _limit));
              return;
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(state.error),
                ),
              ),
            ),
          );
        } else {
          return _buildHistoriesResult(state);
        }
      },
    );
  }

  Widget _buildHistoriesResult(HistoriesResultState state) {
    if (state is HistoriesResultSuccessState) {
      histories = state.historiesResult.data[0];
      _currentPage = state.historiesResult.data[0].currentPage;
      _totalPage = state.historiesResult.data[0].totalPages;
    }

    return Container(
        child: histories.articles.isEmpty
            ? Center(
                child: Text('Histories is empty.'),
              )
            : LazyLoadScrollView(
                onEndOfPage: _loadMoreData,
                child: RefreshIndicator(
                  onRefresh: () {
                    _bloc.add(HistoriesResultFetching(page: 1, limit: _limit));
                    return;
                  },
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(12.0),
                        itemCount: histories.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            child: InkWell(
                              child: ArticleItem(
                                image: histories.articles[index].images.isEmpty
                                    ? ""
                                    : histories.articles[index].images[0].image,
                                title: histories.articles[index].title ?? "",
                                date: histories.articles[index].date ?? "",
                                description:
                                    histories.articles[index].description ?? "",
                              ),
                              onTap: () async {
                                if (index % _interstitialAdFrequency == 0)
                                  _showAds();
                                _navigateToDetails(
                                    context: context,
                                    article: histories.articles[index]);
                              },
                            ),
                          );
                        },
                      ),
                      (state is HistoriesResultLoadingMoreState)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ));
  }

  void _loadMoreData() {
    if (_currentPage < _totalPage) {
      _currentPage++;
      _bloc.add(HistoriesResultFetchingMore(page: _currentPage, limit: _limit));
    }
  }

  void _navigateToDetails(
      {@required BuildContext context, Article article}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsPage(article, ArticleType.history);
    })).then((value) => _admobInterstitial.load());
  }

  void _showAds() async {
    if (await _admobInterstitial.isLoaded) _admobInterstitial.show();
  }
}
