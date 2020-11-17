import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'auth_result.g.dart';

@JsonSerializable()
class AuthResult {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'data')
  List<String> data;
  @JsonKey(name: 'message')
  String message;

  AuthResult({this.status, this.data, this.message});

  factory AuthResult.fromJson(Map<String, dynamic> json) => _$AuthResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResultToJson(this);
}