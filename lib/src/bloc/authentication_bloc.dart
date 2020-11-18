import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/auth_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/auth_result_state.dart';
import 'package:reog_apps_flutter/src/models/auth_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthResultState> {
  final ReogAppsService service;

  AuthenticationBloc({@required this.service})
      : assert(service != null),
        super(AuthResultInitialState());

  @override
  Stream<AuthResultState> mapEventToState(AuthEvent event) async* {
    if (event is Authenticating) {
      yield AuthResultLoadingState();
      try {
        Response response = await service.authenticate(event.auth.toJson());
        if (response.isSuccessful) {
          final authResult = AuthResult.fromJson(response.body);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              AUTH_TOKEN_SHARED_PREFS_KEY, authResult.data[0]);
          yield AuthResultSuccessState(authResult: authResult);
        } else {
          final authResult = AuthResult.fromJson(jsonDecode(response.error));
          yield AuthResultErrorState(error: authResult.message);
          yield AuthResultInitialState();
        }
      } catch (e) {
        yield AuthResultErrorState(error: e.toString());
        yield AuthResultInitialState();
        throw e;
      }
    }
  }
}
