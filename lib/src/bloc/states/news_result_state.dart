import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/articles_result.dart';

abstract class NewsResultState extends Equatable {
  const NewsResultState();
}

class NewsResultInitialState extends NewsResultState {
  @override
  List<Object> get props => [];
}

class NewsResultLoadingState extends NewsResultState {
  @override
  List<Object> get props => [];
}

class NewsResultLoadingMoreState extends NewsResultState {
  @override
  List<Object> get props => [];
}

class NewsResultSuccessState extends NewsResultState {
  final ArticlesResult newsResult;

  NewsResultSuccessState({this.newsResult});

  @override
  List<Object> get props => [newsResult];
}

class NewsResultErrorState extends NewsResultState {
  final String error;

  NewsResultErrorState({this.error});

  @override
  List<Object> get props => [error];
}
