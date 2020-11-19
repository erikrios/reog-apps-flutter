import 'package:equatable/equatable.dart';

abstract class AvatarResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AvatarResultFetching extends AvatarResultEvent {}
