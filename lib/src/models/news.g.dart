// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    news: (json['news'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalPages: json['totalPages'] as int,
    currentPage: json['currentPage'] as int,
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'news': instance.news,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
    };
