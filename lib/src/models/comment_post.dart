import 'package:json_annotation/json_annotation.dart';

part 'comment_post.g.dart';

@JsonSerializable()
class CommentPost {
  @JsonKey(name: 'comment')
  String comment;

  CommentPost({this.comment});

  factory CommentPost.fromJson(Map<String, dynamic> json) =>
      _$CommentPostFromJson(json);

  Map<String, dynamic> toJson() => _$CommentPostToJson(this);
}
