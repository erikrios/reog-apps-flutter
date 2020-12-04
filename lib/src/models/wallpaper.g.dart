// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallpaper _$WallpaperFromJson(Map<String, dynamic> json) {
  return Wallpaper(
    urls: (json['urls'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$WallpaperToJson(Wallpaper instance) => <String, dynamic>{
      'urls': instance.urls,
    };
