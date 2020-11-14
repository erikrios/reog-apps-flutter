import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/articles_result.dart';

abstract class HistoriesResultState extends Equatable {
  const HistoriesResultState();
}

class HistoriesResultInitialState extends HistoriesResultState {
  @override
  List<Object> get props => [];
}

class HistoriesResultLoadingState extends HistoriesResultState {
  @override
  List<Object> get props => [];
}

class HistoriesResultLoadingMoreState extends HistoriesResultState {
  @override
  List<Object> get props => [];
}

class HistoriesResultSuccessState extends HistoriesResultState {
  final ArticlesResult historiesResult;

  HistoriesResultSuccessState({this.historiesResult});

  @override
  List<Object> get props => [historiesResult];
}

class HistoriesResultErrorSState extends HistoriesResultState {
  final String error;

  HistoriesResultErrorSState({this.error});

  @override
  List<Object> get props => [error];
}
