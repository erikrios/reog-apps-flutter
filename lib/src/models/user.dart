import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'lastLogin')
  String lastLogin;
  @JsonKey(name: 'isAdmin')
  bool isAdmin;
  @JsonKey(name: 'dateRegistered')
  String dateRegistered;

  User(
      {this.id,
      this.name,
      this.email,
      this.lastLogin,
      this.isAdmin,
      this.dateRegistered});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
