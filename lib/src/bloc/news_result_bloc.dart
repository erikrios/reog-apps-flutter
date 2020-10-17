import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:reog_apps_flutter/src/bloc/bloc.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class NewsResultBloc implements Bloc {
  final _controller = StreamController<Response>();
  final _client = ReogAppsService.create();
  Stream<Response> get newsResultStream => _controller.stream;

  void getNews() async {
    final results = await _client.getNews();
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
