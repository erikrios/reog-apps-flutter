import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/register_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/register_state.dart';
import 'package:reog_apps_flutter/src/models/user_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ReogAppsService service;

  RegisterBloc({@required this.service})
      : assert(service != null),
        super(RegisterInitialState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is Registering) {
      yield RegisterLoadingState();
      try {
        Response response = await service.register(event.register.toJson());
        if (response.isSuccessful) {
          final String authToken = response.headers['Auth-Token'];
          yield RegisterSuccessState(authToken: authToken);
        } else {
          final userResult = UserResult.fromJson(jsonDecode(response.error));
          yield RegisterErrorState(error: userResult.message);
        }
      } catch (e) {
        yield RegisterErrorState(error: e.toString());
        throw e;
      }
    }
  }
}
