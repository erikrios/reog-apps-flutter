import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/articles_result.dart';

abstract class FoodsResultState extends Equatable {
  const FoodsResultState();
}

class FoodsResultInitialState extends FoodsResultState {
  @override
  List<Object> get props => [];
}

class FoodsResultLoadingState extends FoodsResultState {
  @override
  List<Object> get props => [];
}

class FoodsResultLoadingMoreState extends FoodsResultState {
  @override
  List<Object> get props => [];
}

class FoodsResultSuccessState extends FoodsResultState {
  final ArticlesResult foodsResult;

  FoodsResultSuccessState({this.foodsResult});

  @override
  List<Object> get props => [foodsResult];
}

class FoodsResultErrorState extends FoodsResultState {
  final String error;

  FoodsResultErrorState({this.error});

  @override
  List<Object> get props => [error];
}
