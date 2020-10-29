// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Articles _$ArticlesFromJson(Map<String, dynamic> json) {
  return Articles(
    articles: (json['news'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalPages: json['totalPages'] as int,
    currentPage: json['currentPage'] as int,
  );
}

Map<String, dynamic> _$ArticlesToJson(Articles instance) => <String, dynamic>{
      'news': instance.articles,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
    };
