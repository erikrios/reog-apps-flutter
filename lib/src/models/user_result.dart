import 'package:json_annotation/json_annotation.dart';
import 'package:reog_apps_flutter/src/models/user.dart';

part 'user_result.g.dart';

@JsonSerializable()
class UserResult {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'data')
  List<User> data;
  @JsonKey(name: 'message')
  String message;

  UserResult({this.status, this.data, this.message});

  factory UserResult.fromJson(Map<String, dynamic> json) =>
      _$UserResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserResultToJson(this);
}
