import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/image.dart';

part 'article.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Article extends HiveObject {
  @JsonKey(name: '_id')
  @HiveField(0)
  String id;
  @JsonKey(name: 'title')
  @HiveField(1)
  String title;
  @JsonKey(name: 'description')
  @HiveField(2)
  String description;
  @JsonKey(name: 'date')
  @HiveField(3)
  String date;
  @JsonKey(name: 'views')
  @HiveField(4)
  int views;
  @JsonKey(name: 'images')
  @HiveField(5)
  List<Image> images;

  Article(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.views,
      this.images});

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
