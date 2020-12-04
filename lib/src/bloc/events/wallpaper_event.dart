import 'package:equatable/equatable.dart';

abstract class WallpaperEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WallpaperFetchingEvent extends WallpaperEvent {}
