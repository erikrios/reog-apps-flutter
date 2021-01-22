import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:reog_apps_flutter/src/bloc/events/sites_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/sites_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/states/sites_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/articles.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class SitesPage extends StatefulWidget {
  @override
  _SitesPageState createState() => _SitesPageState();
}

class _SitesPageState extends State<SitesPage> {
  SitesResultBloc _bloc;
  int _currentPage = 1;
  int _totalPage = 1;
  final int _limit = 5;
  Articles sites;
  AdmobInterstitial _admobInterstitial;
  final int _interstitialAdFrequency = 2;
  final _nativeAdController = NativeAdmobController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SitesResultBloc>(context);
    _admobInterstitial =
        AdmobInterstitial(adUnitId: 'ca-app-pub-3940256099942544/1033173712');
    _admobInterstitial.load();
    _nativeAdController.reloadAd(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBlocBuilder(_bloc);
  }

  Widget _buildBlocBuilder(SitesResultBloc bloc) {
    return BlocBuilder<SitesResultBloc, SitesResultState>(
        cubit: bloc,
        builder: (BuildContext context, SitesResultState state) {
          if (state is SitesResultInitialState) {
            bloc.add(SitesResultFetching(page: _currentPage, limit: _limit));
            return Container();
          } else if (state is SitesResultLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SitesResultErrorState) {
            return RefreshIndicator(
              onRefresh: () {
                bloc.add(SitesResultFetching(page: 1, limit: _limit));
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
            return _buildSitesResult(state);
          }
        });
  }

  Widget _buildSitesResult(SitesResultState state) {
    if (state is SitesResultSuccessState) {
      sites = state.sitesResult.data[0];
      _currentPage = state.sitesResult.data[0].currentPage;
      _totalPage = state.sitesResult.data[0].totalPages;
    }
    return Container(
        child: sites.articles.isEmpty
            ? Center(
                child: Text('Sites is empty.'),
              )
            : LazyLoadScrollView(
                onEndOfPage: _loadMoreData,
                child: RefreshIndicator(
                  onRefresh: () {
                    _bloc.add(SitesResultFetching(page: 1, limit: _limit));
                    return;
                  },
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 12.0, right: 12.0, bottom: 12.0),
                        height: 150.0,
                        child: NativeAdmob(
                          adUnitID: 'ca-app-pub-3940256099942544/8135179316',
                          controller: _nativeAdController,
                          type: NativeAdmobType.full,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(12.0),
                        itemCount: sites.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Material(
                            child: InkWell(
                              child: ArticleItem(
                                image: sites.articles[index].images.isEmpty
                                    ? ""
                                    : sites.articles[index].images[0].image,
                                title: sites.articles[index].title ?? "",
                                date: sites.articles[index].date ?? "",
                                description:
                                    sites.articles[index].description ?? "",
                              ),
                              onTap: () async {
                                if (index % _interstitialAdFrequency == 0)
                                  _showAds();
                                _navigateToDetails(
                                    context: context,
                                    article: sites.articles[index]);
                              },
                            ),
                          );
                        },
                      ),
                      (state is SitesResultLoadingMoreState)
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
      _bloc.add(SitesResultFetchingMore(page: _currentPage, limit: _limit));
    }
  }

  void _navigateToDetails(
      {@required BuildContext context, Article article}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsPage(article, ArticleType.sites);
    })).then((value) {
      _admobInterstitial.load();
      _nativeAdController.reloadAd(forceRefresh: true);
    });
  }

  void _showAds() async {
    if (await _admobInterstitial.isLoaded) _admobInterstitial.show();
  }
}
