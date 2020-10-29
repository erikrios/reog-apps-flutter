// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_details_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetailsResult _$ArticleDetailsResultFromJson(Map<String, dynamic> json) {
  return ArticleDetailsResult(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ArticleDetailsResultToJson(
        ArticleDetailsResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
