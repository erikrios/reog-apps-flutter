import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/image.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'date')
  String date;
  @JsonKey(name: 'views')
  int views;
  @JsonKey(name: 'images')
  List<Image> images;

  Article(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.views,
      this.images});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
