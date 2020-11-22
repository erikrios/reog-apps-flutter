import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/user.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'comment')
  String comment;
  @JsonKey(name: 'date')
  String date;
  @JsonKey(name: 'user')
  User user;
  @JsonKey(name: 'article')
  Article article;

  Comment({this.id, this.comment, this.date, this.user, this.article});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
