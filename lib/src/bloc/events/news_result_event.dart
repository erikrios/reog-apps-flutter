import 'package:equatable/equatable.dart';

abstract class NewsResultEvent extends Equatable {
  const NewsResultEvent();

  @override
  List<Object> get props => [];
}

class NewsResultFetching extends NewsResultEvent {}
