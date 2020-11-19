import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/user_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/user_result_state.dart';
import 'package:reog_apps_flutter/src/models/user_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';

class UserResultBloc extends Bloc<UserResultEvent, UserResultState> {
  final ReogAppsService service;

  UserResultBloc({@required this.service})
      : assert(service != null),
        super(UserResultInitialState());

  @override
  Stream<UserResultState> mapEventToState(UserResultEvent event) async* {
    if (event is UserResultFetching) {
      yield UserResultLoadingState();
      try {
        String token = await getAuthToken();
        Response response = await service.getUserDetails(token);

        if (response.isSuccessful) {
          UserResult userResult = UserResult.fromJson(response.body);
          yield UserResultSuccessState(userResult: userResult);
        } else {
          UserResult userResult =
              UserResult.fromJson(jsonDecode(response.error));
          yield UserResultErrorState(error: userResult.message);
        }
      } catch (e) {
        yield UserResultErrorState(error: e.toString());
      }
    }
  }
}
