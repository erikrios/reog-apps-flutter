import 'package:equatable/equatable.dart';

abstract class ArticleDetailsResultEvent extends Equatable {
  const ArticleDetailsResultEvent();

  @override
  List<Object> get props => [];
}

class ArticleDetailsResultFetching extends ArticleDetailsResultEvent {
  final String id;

  const ArticleDetailsResultFetching({this.id});
}
