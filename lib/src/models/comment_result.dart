import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/comment.dart';

part 'comment_result.g.dart';

@JsonSerializable()
class CommentResult {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'data')
  List<Comment> data;
  @JsonKey(name: 'message')
  String message;

  CommentResult({this.status, this.data, this.message});

  factory CommentResult.fromJson(Map<String, dynamic> json) =>
      _$CommentResultFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResultToJson(this);
}
