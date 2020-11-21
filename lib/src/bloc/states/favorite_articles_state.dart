import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/article.dart';

abstract class FavoriteArticlesState extends Equatable {
  const FavoriteArticlesState();
}

class FavoriteArticlesLoadingState extends FavoriteArticlesState {
  @override
  List<Object> get props => [];
}

abstract class FavoriteArticlesSuccessState extends FavoriteArticlesState {}

class FavoriteArticlesSuccessEmptyState extends FavoriteArticlesSuccessState {
  final String message;

  FavoriteArticlesSuccessEmptyState({this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteArticlesSuccessNotEmptyState
    extends FavoriteArticlesSuccessState {
  final List<Article> articles;

  FavoriteArticlesSuccessNotEmptyState({this.articles});

  @override
  List<Object> get props => [articles];
}
