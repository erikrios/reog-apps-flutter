import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/articles_result.dart';

abstract class SitesResultState extends Equatable {
  const SitesResultState();
}

class SitesResultInitialState extends SitesResultState {
  @override
  List<Object> get props => [];
}

class SitesResultLoadingState extends SitesResultState {
  @override
  List<Object> get props => [];
}

class SitesResultLoadingMoreState extends SitesResultState {
  @override
  List<Object> get props => [];
}

class SitesResultSuccessState extends SitesResultState {
  final ArticlesResult sitesResult;

  SitesResultSuccessState({this.sitesResult});

  @override
  List<Object> get props => [sitesResult];
}

class SitesResultErrorState extends SitesResultState {
  final String error;

  SitesResultErrorState({this.error});

  @override
  List<Object> get props => [error];
}
