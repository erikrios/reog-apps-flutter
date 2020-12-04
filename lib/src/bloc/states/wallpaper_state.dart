import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/wallpaper_result.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();
}

class WallpaperLoadingState extends WallpaperState {
  @override
  List<Object> get props => [];
}

class WallpaperSuccessState extends WallpaperState {
  final WallpaperResult wallpaperResult;

  const WallpaperSuccessState(this.wallpaperResult);

  @override
  List<Object> get props => [wallpaperResult];
}

class WallpaperErrorState extends WallpaperState {
  final String error;

  const WallpaperErrorState({this.error});

  @override
  List<Object> get props => [error];
}
