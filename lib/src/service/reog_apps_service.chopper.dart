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
}
