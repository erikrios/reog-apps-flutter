import 'package:equatable/equatable.dart';

abstract class NewsDetailsResultEvent extends Equatable {
  const NewsDetailsResultEvent();

  @override
  List<Object> get props => [];
}

class NewsDetailsResultFetching extends NewsDetailsResultEvent {
  final String id;

  const NewsDetailsResultFetching({this.id});
}
