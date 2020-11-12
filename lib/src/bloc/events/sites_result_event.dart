import 'package:equatable/equatable.dart';

abstract class SitesResultEvent extends Equatable {
  const SitesResultEvent();

  @override
  List<Object> get props => [];
}

class SitesResultFetching extends SitesResultEvent {
  final int page;
  final int limit;

  const SitesResultFetching({this.page = 1, this.limit = 10});
}

class SitesResultFetchingMore extends SitesResultEvent {
  final int page;
  final int limit;

  const SitesResultFetchingMore({this.page, this.limit});
}
