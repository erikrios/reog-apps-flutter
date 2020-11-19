import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/user_result.dart';

abstract class UserResultState extends Equatable {
  const UserResultState();
}

class UserResultInitialState extends UserResultState {
  @override
  List<Object> get props => [];
}

class UserResultLoadingState extends UserResultState {
  @override
  List<Object> get props => [];
}

class UserResultSuccessState extends UserResultState {
  final UserResult userResult;

  const UserResultSuccessState({this.userResult});

  @override
  List<Object> get props => [userResult];
}

class UserResultErrorState extends UserResultState {
  final String error;

  const UserResultErrorState({this.error});

  @override
  List<Object> get props => [error];
}
