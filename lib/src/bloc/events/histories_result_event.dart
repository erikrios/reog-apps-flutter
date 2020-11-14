import 'package:equatable/equatable.dart';

abstract class HistoriesResultEvent extends Equatable {
  const HistoriesResultEvent();

  @override
  List<Object> get props => [];
}

class HistoriesResultFetching extends HistoriesResultEvent {
  final int page;
  final int limit;

  const HistoriesResultFetching({this.page = 1, this.limit = 10});
}

class HistoriesResultFetchingMore extends HistoriesResultEvent {
  final int page;
  final int limit;

  const HistoriesResultFetchingMore({this.page, this.limit});
}
