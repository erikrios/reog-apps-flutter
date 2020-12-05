import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/favorite_articles_event.dart';
import 'package:reog_apps_flutter/src/bloc/favorite_articles_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/states/favorite_articles_state.dart';
import 'package:reog_apps_flutter/src/db/favorites_db.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/article_item.dart';
import 'package:reog_apps_flutter/src/screens/widgets/brightness_menu.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';
import 'package:startapp/startapp.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  ScrollController _scrollViewController;
  FavoriteArticlesBloc _bloc = FavoriteArticlesBloc();
  bool _isLoggedIn;

  _FavoritesPageState() {
    _bloc.add(GetFavoriteArticlesEvent());
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    getAuthToken().then((value) {
      setState(() {
        _isLoggedIn = value == null ? false : true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _navigateBack();
      },
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text('Favorites'),
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    _navigateBack();
                  },
                ),
                actions: [
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
              )
            ];
          },
          body: BlocBuilder<FavoriteArticlesBloc, FavoriteArticlesState>(
            cubit: _bloc,
            builder: (BuildContext context, FavoriteArticlesState state) {
              if (state is FavoriteArticlesLoadingState)
                return _buildLoading();
              else
                return _buildFavoriteArticles(
                    state as FavoriteArticlesSuccessState, _bloc);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildFavoriteArticles(
      FavoriteArticlesSuccessState state, FavoriteArticlesBloc bloc) {
    if (state is FavoriteArticlesSuccessEmptyState) {
      return Container(
        child: Center(
          child: Text(
            state.message,
          ),
        ),
      );
    } else {
      FavoriteArticlesSuccessNotEmptyState notEmptyState =
          state as FavoriteArticlesSuccessNotEmptyState;
      List<Article> articles = notEmptyState.articles;
      return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(12.0),
          itemCount: articles.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              background: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Remove from favorites.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              key: Key(articles[index].id),
              onDismissed: (DismissDirection direction) {
                bloc.add(DeleteFavoriteArticleEvent(articles[index].id));
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('${articles[index].title} removed.')));
              },
              child: Material(
                child: InkWell(
                  child: ArticleItem(
                    image: articles[index].images[0].image,
                    title: articles[index].title,
                    date: articles[index].date,
                    description: articles[index].description,
                  ),
                  onTap: () async {
                    await StartApp.showInterstitialAd();
                    ArticleType type = FavoritesDb.getFavoriteArticleTypeById(
                        articles[index].id);
                    _navigateToDetails(
                        context: context, article: articles[index], type: type);
                  },
                ),
              ),
            );
          });
    }
  }

  void _navigateToDetails(
      {@required BuildContext context,
      @required Article article,
      @required ArticleType type}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return DetailsPage(article, type);
    })).then((value) => _bloc.add(GetFavoriteArticlesEvent()));
  }

  void _navigateBack() {
    Navigator.pop(context, true);
  }
}
