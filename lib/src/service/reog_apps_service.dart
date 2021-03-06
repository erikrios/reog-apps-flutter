import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'reog_apps_service.chopper.dart';

@ChopperApi()
abstract class ReogAppsService extends ChopperService {
  @Get(path: 'api/news')
  Future<Response> getNews(
      {@Query('page') int page = 1, @Query('limit') int limit = 10});

  @Get(path: 'api/news/{id}')
  Future<Response> getNewsDetails(@Path('id') String id);

  @Get(path: 'api/sites')
  Future<Response> getSites(
      {@Query('page') int page = 1, @Query('limit') int limit = 10});

  @Get(path: 'api/sites/{id}')
  Future<Response> getSitesDetails(@Path('id') String id);

  @Get(path: 'api/foods')
  Future<Response> getFoods(
      {@Query('page') int page = 1, @Query('limit') int limit = 10});

  @Get(path: 'api/foods/{id}')
  Future<Response> getFoodsDetails(@Path('id') String id);

  @Get(path: 'api/histories')
  Future<Response> getHistories(
      {@Query('page') int page = 1, @Query('limit') int limit = 10});

  @Get(path: 'api/histories/{id}')
  Future<Response> getHistoriesDetails(@Path('id') String id);

  @Post(path: 'api/auth')
  Future<Response> authenticate(@Body() Map<String, dynamic> body);

  @Get(path: '/api/users/me')
  Future<Response> getUserDetails(@Header('Auth-Token') String authToken);

  @Get(path: 'api/users/avatar')
  Future<Response> getAvatar(@Header('Auth-Token') String authToken);

  @Post(path: 'api/comments')
  Future<Response> postComment(@Header('Auth-Token') String authToken,
      @Query('id') String id, @Body() Map<String, dynamic> body);

  @Get(path: 'api/comments')
  Future<Response> getComments(@Query('id') String id);

  @Get(path: 'api/wallpapers')
  Future<Response> getWallpapers();

  @Post(path: 'api/users')
  Future<Response> register(@Body() Map<String, dynamic> body);

  static ReogAppsService create({String authTokenValue = ""}) {
    final client = ChopperClient(
      baseUrl: DotEnv().env['BASE_URL'],
      services: [
        _$ReogAppsService(),
      ],
      interceptors: [
        HttpLoggingInterceptor(),
        // HeaderInterceptor(authTokenValue: authTokenValue),
      ],
      converter: JsonConverter(),
    );

    return _$ReogAppsService(client);
  }
}
