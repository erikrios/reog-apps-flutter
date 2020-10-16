import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/news.dart';

part 'news_result.g.dart';

@JsonSerializable()
class NewsResult {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'data')
  List<News> data;
  @JsonKey(name: 'message')
  String message;

  NewsResult({this.status, this.data, this.message});

  factory NewsResult.fromJson(Map<String, dynamic> json) => _$NewsResultFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResultToJson(this);
}
