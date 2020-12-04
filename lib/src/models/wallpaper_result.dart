import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/wallpaper.dart';

part 'wallpaper_result.g.dart';

@JsonSerializable()
class WallpaperResult {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'data')
  List<Wallpaper> data;
  @JsonKey(name: 'message')
  String message;

  WallpaperResult({this.status, this.data, this.message});

  factory WallpaperResult.fromJson(Map<String, dynamic> json) =>
      _$WallpaperResultFromJson(json);

  Map<String, dynamic> toJson() => _$WallpaperResultToJson(this);
}
