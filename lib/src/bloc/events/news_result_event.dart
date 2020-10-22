import 'package:equatable/equatable.dart';

abstract class NewsResultEvent extends Equatable {
  const NewsResultEvent();

  @override
  List<Object> get props => [];
}

class NewsResultFetching extends NewsResultEvent {
  final int page;
  final int limit;

  const NewsResultFetching({this.page, this.limit});
}
