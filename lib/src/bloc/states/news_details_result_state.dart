import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/article_details_result.dart';

abstract class NewsDetailsResultState extends Equatable {
  const NewsDetailsResultState();
}

class NewsDetailsResultInitialState extends NewsDetailsResultState {
  @override
  List<Object> get props => [];
}

class NewsDetailsResultLoadingState extends NewsDetailsResultState {
  @override
  List<Object> get props => [];
}

class NewsDetailsResultSuccessState extends NewsDetailsResultState {
  final ArticleDetailsResult newsDetailsResult;

  NewsDetailsResultSuccessState({this.newsDetailsResult});

  @override
  List<Object> get props => [newsDetailsResult];
}

class NewsDetailsResultErrorState extends NewsDetailsResultState {
  final String error;

  NewsDetailsResultErrorState({this.error});

  @override
  List<Object> get props => [error];
}
