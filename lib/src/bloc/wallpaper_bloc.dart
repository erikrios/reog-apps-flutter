import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/wallpaper_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/wallpaper_state.dart';
import 'package:reog_apps_flutter/src/models/wallpaper_result.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ReogAppsService service;

  WallpaperBloc({@required this.service})
      : assert(service != null),
        super(WallpaperLoadingState());

  @override
  Stream<WallpaperState> mapEventToState(WallpaperEvent event) async* {
    if (event is WallpaperFetchingEvent) {
      yield WallpaperLoadingState();
      try {
        Response response = await service.getWallpapers();
        if (response.isSuccessful) {
          WallpaperResult wallpaperResult =
              WallpaperResult.fromJson(response.body);
          yield WallpaperSuccessState(wallpaperResult: wallpaperResult);
        } else {
          WallpaperResult wallpaperResult =
              WallpaperResult.fromJson(jsonDecode(response.error));
          yield WallpaperErrorState(error: wallpaperResult.message);
        }
      } catch (e) {
        yield WallpaperErrorState(error: e.toString());
      }
    }
  }
}
