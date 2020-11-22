import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/comment_post.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentPostEvent extends CommentEvent {
  final String token;
  final String id;
  final CommentPost comment;

  CommentPostEvent(this.token, this.id, this.comment);
}

class CommentGetEvent extends CommentEvent {
  final String id;

  CommentGetEvent(this.id);
}
