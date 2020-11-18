import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/histories_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/histories_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/articles_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class HistoriesResultBloc
    extends Bloc<HistoriesResultEvent, HistoriesResultState> {
  final ReogAppsService service;
  final List<Article> histories = [];

  HistoriesResultBloc({@required this.service})
      : assert(service != null),
        super(HistoriesResultInitialState());

  @override
  Stream<HistoriesResultState> mapEventToState(
      HistoriesResultEvent event) async* {
    if (event is HistoriesResultFetching) {
      yield HistoriesResultLoadingState();
      try {
        Response response =
            await service.getHistories(page: event.page, limit: event.limit);
        if (response.isSuccessful) {
          final historiesResult = ArticlesResult.fromJson(response.body);
          histories.clear();
          histories.addAll(historiesResult.data[0].articles);
          yield HistoriesResultSuccessState(historiesResult: historiesResult);
        } else {
          final historiesResult =
              ArticlesResult.fromJson(jsonDecode(response.error));
          yield HistoriesResultErrorSState(error: historiesResult.message);
        }
      } catch (e) {
        yield HistoriesResultErrorSState(error: e.toString());
      }
    } else if (event is HistoriesResultFetchingMore) {
      yield HistoriesResultLoadingMoreState();
      try {
        Response response =
            await service.getHistories(page: event.page, limit: event.limit);
        if (response.isSuccessful) {
          final historiesResult = ArticlesResult.fromJson(response.body);
          histories.addAll(historiesResult.data[0].articles);
          historiesResult.data[0].articles.clear();
          historiesResult.data[0].articles.addAll(histories);
          yield HistoriesResultSuccessState(historiesResult: historiesResult);
        } else {
          final historiesResult =
              ArticlesResult.fromJson(jsonDecode(response.error));
          yield HistoriesResultErrorSState(error: historiesResult.message);
        }
      } catch (e) {
        yield HistoriesResultErrorSState(error: e.toString());
      }
    }
  }
}
