import 'package:chopper/chopper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reog_apps_flutter/src/service/header_interceptor.dart';

part 'reog_apps_service.chopper.dart';

@ChopperApi()
abstract class ReogAppsService extends ChopperService {
  @Get(path: 'api/news')
  Future<Response> getNews(
      {@Query('page') int page = 1, @Query('limit') int limit = 10});

  static ReogAppsService create({String authTokenValue = ""}) {
    final client = ChopperClient(
      baseUrl: DotEnv().env['BASE_URL'],
      services: [
        _$ReogAppsService(),
      ],
      interceptors: [
        HttpLoggingInterceptor(),
        HeaderInterceptor(authTokenValue: authTokenValue),
      ],
    );

    return _$ReogAppsService(client);
  }
}
