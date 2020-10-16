import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/article.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  @JsonKey(name: 'news')
  List<Article> news;
  @JsonKey(name: 'totalPages')
  int totalPages;
  @JsonKey(name: 'currentPage')
  int currentPage;

  News({this.news, this.totalPages, this.currentPage});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
