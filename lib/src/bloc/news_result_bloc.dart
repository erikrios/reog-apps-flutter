import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/news_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/news_result_state.dart';
import 'package:reog_apps_flutter/src/models/news_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class NewsResultBloc extends Bloc<NewsResultEvent, NewsResultState> {
  final ReogAppsService service;

  NewsResultBloc({@required this.service})
      : assert(service != null),
        super(NewsResultLoadingState());

  @override
  Stream<NewsResultState> mapEventToState(NewsResultEvent event) async* {
    if (event is NewsResultFetching) {
      yield NewsResultLoadingState();
      try {
        Response response =
            await service.getNews(page: event.page, limit: event.limit);
        final newsResult = NewsResult.fromJson(jsonDecode(response.body));
        yield NewsResultSuccessState(newsResult: newsResult);
      } catch (e) {
        yield NewsResultErrorState(error: e.toString());
      }
    }
  }
}
