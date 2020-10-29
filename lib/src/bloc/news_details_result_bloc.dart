import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/news_details_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/news_details_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/article_details_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class NewsDetailsResultBloc
    extends Bloc<NewsDetailsResultEvent, NewsDetailsResultState> {
  final ReogAppsService service;
  Article article = Article();

  NewsDetailsResultBloc({@required this.service})
      : assert(service != null),
        super(NewsDetailsResultInitialState());

  @override
  Stream<NewsDetailsResultState> mapEventToState(
      NewsDetailsResultEvent event) async* {
    if (event is NewsDetailsResultFetching) {
      yield NewsDetailsResultLoadingState();
      try {
        Response response = await service.getNewsDetails(event.id);
        final newsDetailsResult = ArticleDetailsResult.fromJson(response.body);
        article = newsDetailsResult.data[0];
        yield NewsDetailsResultSuccessState(
            newsDetailsResult: newsDetailsResult);
      } catch (e) {
        yield NewsDetailsResultErrorState(error: e.toString());
      }
    }
  }
}
