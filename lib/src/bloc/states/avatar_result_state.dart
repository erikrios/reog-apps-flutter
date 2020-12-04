import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/avatar_result.dart';

abstract class AvatarResultState extends Equatable {
  const AvatarResultState();
}

class AvatarResultLoadingState extends AvatarResultState {
  @override
  List<Object> get props => [];
}

class AvatarResultSuccessState extends AvatarResultState {
  final AvatarResult avatarResult;

  const AvatarResultSuccessState({this.avatarResult});

  @override
  List<Object> get props => [avatarResult];
}

class AvatarResultErrorState extends AvatarResultState {
  final String error;

  const AvatarResultErrorState({this.error});

  @override
  List<Object> get props => [error];
}
