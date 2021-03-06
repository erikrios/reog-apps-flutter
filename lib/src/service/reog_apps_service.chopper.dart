// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reog_apps_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ReogAppsService extends ReogAppsService {
  _$ReogAppsService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ReogAppsService;

  @override
  Future<Response<dynamic>> getNews({int page = 1, int limit = 10}) {
    final $url = 'api/news';
    final $params = <String, dynamic>{'page': page, 'limit': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNewsDetails(String id) {
    final $url = 'api/news/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSites({int page = 1, int limit = 10}) {
    final $url = 'api/sites';
    final $params = <String, dynamic>{'page': page, 'limit': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSitesDetails(String id) {
    final $url = 'api/sites/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFoods({int page = 1, int limit = 10}) {
    final $url = 'api/foods';
    final $params = <String, dynamic>{'page': page, 'limit': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFoodsDetails(String id) {
    final $url = 'api/foods/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getHistories({int page = 1, int limit = 10}) {
    final $url = 'api/histories';
    final $params = <String, dynamic>{'page': page, 'limit': limit};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getHistoriesDetails(String id) {
    final $url = 'api/histories/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> authenticate(Map<String, dynamic> body) {
    final $url = 'api/auth';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserDetails(String authToken) {
    final $url = '/api/users/me';
    final $headers = {'Auth-Token': authToken};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAvatar(String authToken) {
    final $url = 'api/users/avatar';
    final $headers = {'Auth-Token': authToken};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postComment(
      String authToken, String id, Map<String, dynamic> body) {
    final $url = 'api/comments';
    final $params = <String, dynamic>{'id': id};
    final $headers = {'Auth-Token': authToken};
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl,
        body: $body, parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getComments(String id) {
    final $url = 'api/comments';
    final $params = <String, dynamic>{'id': id};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWallpapers() {
    final $url = 'api/wallpapers';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> register(Map<String, dynamic> body) {
    final $url = 'api/users';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
