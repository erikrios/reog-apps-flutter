import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/avatar_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/avatar_result_state.dart';
import 'package:reog_apps_flutter/src/models/avatar_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';

class AvatarResultBloc extends Bloc<AvatarResultEvent, AvatarResultState> {
  ReogAppsService service;

  AvatarResultBloc({@required this.service})
      : assert(service != null),
        super(AvatarResultLoadingState());

  @override
  Stream<AvatarResultState> mapEventToState(AvatarResultEvent event) async* {
    if (event is AvatarResultFetching) {
      yield AvatarResultLoadingState();
      try {
        String token = await getAuthToken();
        Response response = await service.getAvatar(token ?? "");
        if (response.isSuccessful) {
          AvatarResult avatarResult = AvatarResult.fromJson(response.body);
          yield AvatarResultSuccessState(avatarResult: avatarResult);
        } else {
          AvatarResult avatarResult =
              AvatarResult.fromJson(jsonDecode(response.error));
          yield AvatarResultErrorState(error: avatarResult.message);
        }
      } catch (e) {
        yield AvatarResultErrorState(error: e.toString());
      }
    }
  }
}
