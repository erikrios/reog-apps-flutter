import 'package:equatable/equatable.dart';

class FavoriteArticlesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFavoriteArticlesEvent extends FavoriteArticlesEvent {}

class DeleteFavoriteArticleEvent extends FavoriteArticlesEvent {
  final String id;

  DeleteFavoriteArticleEvent({this.id});
}
