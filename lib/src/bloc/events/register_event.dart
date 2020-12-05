import 'package:equatable/equatable.dart';
import 'package:reog_apps_flutter/src/models/register.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class Registering extends RegisterEvent {
  final Register register;

  const Registering(this.register);
}
