import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/auth_result.dart';

abstract class AuthResultState extends Equatable {
  const AuthResultState();
}

class AuthResultInitialState extends AuthResultState {
  @override
  List<Object> get props => [];
}

class AuthResultLoadingState extends AuthResultState {
  @override
  List<Object> get props => [];
}

class AuthResultSuccessState extends AuthResultState {
  final AuthResult authResult;

  const AuthResultSuccessState({this.authResult});

  @override
  List<Object> get props => [authResult];
}

class AuthResultErrorState extends AuthResultSuccessState {
  final String error;

  const AuthResultErrorState({this.error});

  @override
  List<Object> get props => [error];
}
