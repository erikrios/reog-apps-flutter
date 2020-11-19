import 'package:equatable/equatable.dart';

abstract class UserResultEvent extends Equatable {
  const UserResultEvent();

  @override
  List<Object> get props => [];
}

class UserResultFetching extends UserResultEvent {}
