// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResult _$NewsResultFromJson(Map<String, dynamic> json) {
  return NewsResult(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : News.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$NewsResultToJson(NewsResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
