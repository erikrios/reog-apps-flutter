
import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/foods_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/foods_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/articles_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class FoodsResultBloc extends Bloc<FoodsResultEvent, FoodsResultState> {
  final ReogAppsService service;
  final List<Article> foods = [];

  FoodsResultBloc({@required this.service})
      : assert(service != null),
        super(FoodsResultInitialState());

  @override
  Stream<FoodsResultState> mapEventToState(FoodsResultEvent event) async* {
    if (event is FoodsResultFetching) {
      yield FoodsResultLoadingState();
      try {
        Response response =
            await service.getFoods(page: event.page, limit: event.limit);
        if (response.isSuccessful) {
          final foodsResult = ArticlesResult.fromJson(response.body);
          foods.clear();
          foods.addAll(foodsResult.data[0].articles);
          yield FoodsResultSuccessState(foodsResult: foodsResult);
        } else {
          final foodsResult = ArticlesResult.fromJson(response.error);
          yield FoodsResultErrorState(error: foodsResult.message);
        }
      } catch (e) {
        yield FoodsResultErrorState(error: e.toString());
      }
    } else if (event is FoodsResultFetchingMore) {
      yield FoodsResultLoadingMoreState();
      try {
        Response response =
            await service.getFoods(page: event.page, limit: event.limit);
        if (response.isSuccessful) {
          final foodsResult = ArticlesResult.fromJson(response.body);
          foods.addAll(foodsResult.data[0].articles);
          foodsResult.data[0].articles.clear();
          foodsResult.data[0].articles.addAll(foods);
          yield FoodsResultSuccessState(foodsResult: foodsResult);
        } else {
          final foodsResult = ArticlesResult.fromJson(response.error);
          yield FoodsResultErrorState(error: foodsResult.message);
        }
      } catch (e) {
        yield FoodsResultErrorState(error: e.toString());
      }
    }
  }
}
