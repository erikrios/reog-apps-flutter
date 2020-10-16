import 'dart:async';

import 'package:chopper/chopper.dart';

class HeaderInterceptor implements RequestInterceptor {
  static const String AUTH_TOKEN_KEY = 'Auth-Token';
  final String authTokenValue;

  HeaderInterceptor({this.authTokenValue = ""});

  @override
  FutureOr<Request> onRequest(Request request) async {
    Request newRequest =
        request.copyWith(headers: {AUTH_TOKEN_KEY: authTokenValue});

    return newRequest;
  }
}
