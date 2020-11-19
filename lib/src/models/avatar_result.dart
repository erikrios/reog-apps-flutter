import 'package:json_annotation/json_annotation.dart';

part 'avatar_result.g.dart';

@JsonSerializable()
class AvatarResult {
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'data')
  List<String> data;
  @JsonKey(name: 'message')
  String message;

  AvatarResult({this.status, this.data, this.message});

  factory AvatarResult.fromJson(Map<String, dynamic> json) =>
      _$AvatarResultFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarResultToJson(this);
}
