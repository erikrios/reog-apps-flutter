import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/articles.dart';

part 'articles_result.g.dart';

@JsonSerializable()
class ArticlesResult {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'data')
  List<Articles> data;
  @JsonKey(name: 'message')
  String message;

  ArticlesResult({this.status, this.data, this.message});

  factory ArticlesResult.fromJson(Map<String, dynamic> json) =>
      _$ArticlesResultFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesResultToJson(this);
}
