import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/favorite_articles_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/favorite_articles_state.dart';
import 'package:reog_apps_flutter/src/db/favorites_db.dart';
import 'package:reog_apps_flutter/src/models/article.dart';

class FavoriteArticlesBloc
    extends Bloc<FavoriteArticlesEvent, FavoriteArticlesState> {
  FavoriteArticlesBloc() : super(FavoriteArticlesLoadingState());

  @override
  Stream<FavoriteArticlesState> mapEventToState(
      FavoriteArticlesEvent event) async* {
    if (event is GetFavoriteArticlesEvent) {
      yield FavoriteArticlesLoadingState();
      List<Article> articles = FavoritesDb.getFavoriteArticles();
      yield articles.isEmpty
          ? FavoriteArticlesSuccessEmptyState(message: 'Favorite is empty.')
          : FavoriteArticlesSuccessNotEmptyState(articles: articles);
    } else {
      yield FavoriteArticlesLoadingState();
      FavoritesDb.deleteFavoriteArticleById(
          (event as DeleteFavoriteArticleEvent).id);
      this.add(GetFavoriteArticlesEvent());
    }
  }
}
