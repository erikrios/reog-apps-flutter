import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/sites_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/sites_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/articles_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class SitesResultBloc extends Bloc<SitesResultEvent, SitesResultState> {
  final ReogAppsService service;
  final List<Article> sites = [];

  SitesResultBloc({@required this.service})
      : assert(service != null),
        super(SitesResultInitialState());

  @override
  Stream<SitesResultState> mapEventToState(SitesResultEvent event) async* {
    if (event is SitesResultFetching) {
      yield SitesResultLoadingState();
      try {
        Response response =
            await service.getSites(page: event.page, limit: event.limit);
        final sitesResult = ArticlesResult.fromJson(jsonDecode(response.body));
        sites.clear();
        sites.addAll(sitesResult.data[0].articles);
        yield SitesResultSuccessState(sitesResult: sitesResult);
      } catch (e) {
        yield SitesResultErrorState(error: e.toString());
      }
    } else if (event is SitesResultFetchingMore) {
      yield SitesResultLoadingMoreState();
      try {
        Response response =
            await service.getSites(page: event.page, limit: event.limit);
        final sitesResult = ArticlesResult.fromJson(jsonDecode(response.body));
        sites.addAll(sitesResult.data[0].articles);
        sitesResult.data[0].articles.clear();
        sitesResult.data[0].articles.addAll(sites);
        yield SitesResultSuccessState(sitesResult: sitesResult);
      } catch (e) {
        yield SitesResultErrorState(error: e.toString());
      }
    }
  }
}
