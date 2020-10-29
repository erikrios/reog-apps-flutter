import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/article.dart';

part 'articles.g.dart';

@JsonSerializable()
class Articles {
  @JsonKey(name: 'news')
  List<Article> articles;
  @JsonKey(name: 'totalPages')
  int totalPages;
  @JsonKey(name: 'currentPage')
  int currentPage;

  Articles({this.articles, this.totalPages, this.currentPage});

  factory Articles.fromJson(Map<String, dynamic> json) =>
      _$ArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}
