import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/article_details_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/article_details_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/article_details_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class ArticleDetailsResultBloc
    extends Bloc<ArticleDetailsResultEvent, ArticleDetailsResultState> {
  final ReogAppsService service;
  final ArticleType type;
  Article article = Article();

  ArticleDetailsResultBloc({@required this.service, @required this.type})
      : assert(service != null),
        super(ArticleDetailsResultInitialState());

  @override
  Stream<ArticleDetailsResultState> mapEventToState(
      ArticleDetailsResultEvent event) async* {
    if (event is ArticleDetailsResultFetching) {
      yield ArticleDetailsResultLoadingState();
      try {
        Response response = await _getResponse(service, type, event.id);
        print(response.body);
        final articleDetailsResult =
            ArticleDetailsResult.fromJson(jsonDecode(response.body));
        article = articleDetailsResult.data[0];
        yield ArticleDetailsResultSuccessState(
            articleDetailsResult: articleDetailsResult);
      } catch (e) {
        yield ArticleDetailsResultErrorState(error: e.toString());
      }
    }
  }

  Future<Response> _getResponse(
      ReogAppsService service, ArticleType type, String articleId) async {
    Future<Response> response;
    switch (type) {
      case ArticleType.news:
        response = service.getNewsDetails(articleId);
        break;
      case ArticleType.foods:
        response = service.getFoodsDetails(articleId);
        break;
      case ArticleType.sites:
        response = service.getSitesDetails(articleId);
        break;
      case ArticleType.history:
        // TODO
        break;
    }
    return response;
  }
}
