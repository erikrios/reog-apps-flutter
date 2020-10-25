import 'package:equatable/equatable.dart';

abstract class NewsResultEvent extends Equatable {
  const NewsResultEvent();

  @override
  List<Object> get props => [];
}

class NewsResultFetching extends NewsResultEvent {
  final int page;
  final int limit;

  const NewsResultFetching({this.page = 1, this.limit = 10});
}

class NewsResultFetchingMore extends NewsResultEvent {
  final int page;
  final int limit;

  const NewsResultFetchingMore({this.page, this.limit});
}
