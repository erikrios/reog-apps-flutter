import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/article_details_result.dart';

abstract class ArticleDetailsResultState extends Equatable {
  const ArticleDetailsResultState();
}

class ArticleDetailsResultInitialState extends ArticleDetailsResultState {
  @override
  List<Object> get props => [];
}

class ArticleDetailsResultLoadingState extends ArticleDetailsResultState {
  @override
  List<Object> get props => [];
}

class ArticleDetailsResultSuccessState extends ArticleDetailsResultState {
  final ArticleDetailsResult articleDetailsResult;

  ArticleDetailsResultSuccessState({this.articleDetailsResult});

  @override
  List<Object> get props => [articleDetailsResult];
}

class ArticleDetailsResultErrorState extends ArticleDetailsResultState {
  final String error;

  ArticleDetailsResultErrorState({this.error});

  @override
  List<Object> get props => [error];
}
