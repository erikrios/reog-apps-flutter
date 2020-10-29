import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/article.dart';

part 'article_details_result.g.dart';

@JsonSerializable()
class ArticleDetailsResult {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'data')
  List<Article> data;
  @JsonKey(name: 'message')
  String message;

  ArticleDetailsResult({this.status, this.data, this.message});

  factory ArticleDetailsResult.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailsResultFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDetailsResultToJson(this);
}