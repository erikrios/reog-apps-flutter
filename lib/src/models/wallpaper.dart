import 'package:json_annotation/json_annotation.dart';

part 'wallpaper.g.dart';

@JsonSerializable()
class Wallpaper {
  @JsonKey(name: 'urls')
  List<String> urls;

  Wallpaper({this.urls});

  factory Wallpaper.fromJson(Map<String, dynamic> json) =>
      _$WallpaperFromJson(json);

  Map<String, dynamic> toJson() => _$WallpaperToJson(this);
}
