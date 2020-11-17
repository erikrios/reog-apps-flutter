import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Authenticating extends AuthEvent {
  final Auth auth;

  const Authenticating(this.auth);
}
