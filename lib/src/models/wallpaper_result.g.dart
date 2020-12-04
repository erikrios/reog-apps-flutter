// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallpaperResult _$WallpaperResultFromJson(Map<String, dynamic> json) {
  return WallpaperResult(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Wallpaper.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$WallpaperResultToJson(WallpaperResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
