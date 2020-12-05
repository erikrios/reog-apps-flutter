import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends RegisterState {
  final String authToken;

  const RegisterSuccessState({this.authToken});

  @override
  List<Object> get props => [authToken];
}

class RegisterErrorState extends RegisterState {
  final String error;

  const RegisterErrorState({this.error});

  @override
  List<Object> get props => [error];
}
