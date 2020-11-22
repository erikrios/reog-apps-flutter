import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/comment_result.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitialState extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentLoadingState extends CommentState {
  @override
  List<Object> get props => [];
}

abstract class CommentSuccessState extends CommentState {}

class CommentSuccessEmptyState extends CommentSuccessState {
  final String message;

  CommentSuccessEmptyState(this.message);

  @override
  List<Object> get props => [message];
}

class CommentSuccessNotEmptyState extends CommentSuccessState {
  final CommentResult commentResult;

  CommentSuccessNotEmptyState(this.commentResult);

  @override
  List<Object> get props => [commentResult];
}

class CommentErrorState extends CommentState {
  final String error;

  CommentErrorState(this.error);

  @override
  List<Object> get props => [error];
}
