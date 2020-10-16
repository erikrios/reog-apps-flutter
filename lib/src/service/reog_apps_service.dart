import 'package:chopper/chopper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reog_apps_flutter/src/models/news_result.dart';

part 'reog_apps_service.chopper.dart';

@ChopperApi()
abstract class ReogAppsService extends ChopperService {
  @Get(path: 'api/news')
  Future<Response<NewsResult>> getNews(
      {@Query('page') int page, @Query('limit') int limit = 20});

  static ReogAppsService create() {
    final client = ChopperClient(
      baseUrl: DotEnv().env['BASE_URL'],
      services: [
        _$ReogAppsService(),
      ],
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$ReogAppsService(client);
  }
}
