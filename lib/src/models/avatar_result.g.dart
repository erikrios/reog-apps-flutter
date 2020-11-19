// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarResult _$AvatarResultFromJson(Map<String, dynamic> json) {
  return AvatarResult(
    status: json['status'] as String,
    data: (json['data'] as List)?.map((e) => e as String)?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$AvatarResultToJson(AvatarResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
