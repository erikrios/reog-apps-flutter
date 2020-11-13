import 'package:equatable/equatable.dart';

abstract class FoodsResultEvent extends Equatable {
  const FoodsResultEvent();

  @override
  List<Object> get props => [];
}

class FoodsResultFetching extends FoodsResultEvent {
  final int page;
  final int limit;

  const FoodsResultFetching({this.page = 1, this.limit = 10});
}

class FoodsResultFetchingMore extends FoodsResultEvent {
  final int page;
  final int limit;

  const FoodsResultFetchingMore({this.page, this.limit});
}
