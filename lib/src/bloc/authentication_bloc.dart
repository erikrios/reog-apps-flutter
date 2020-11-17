import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/auth_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/auth_result_state.dart';
import 'package:reog_apps_flutter/src/models/auth_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

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
        final authResult = AuthResult.fromJson(jsonDecode(response.body));
        if (response.isSuccessful) {
          yield AuthResultSuccessState(authResult: authResult);
          print(authResult.data[0]);
        } else
          yield AuthResultErrorState(error: authResult.message);
      } catch (e) {
        yield AuthResultErrorState(error: e.toString());
      }
    }
  }
}
