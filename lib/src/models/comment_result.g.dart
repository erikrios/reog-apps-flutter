// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResult _$CommentResultFromJson(Map<String, dynamic> json) {
  return CommentResult(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CommentResultToJson(CommentResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
