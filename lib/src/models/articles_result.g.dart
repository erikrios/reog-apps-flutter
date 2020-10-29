// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesResult _$ArticlesResultFromJson(Map<String, dynamic> json) {
  return ArticlesResult(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Articles.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ArticlesResultToJson(ArticlesResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
