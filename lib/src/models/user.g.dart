// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['_id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    lastLogin: json['lastLogin'] as String,
    isAdmin: json['isAdmin'] as bool,
    dateRegistered: json['dateRegistered'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'lastLogin': instance.lastLogin,
      'isAdmin': instance.isAdmin,
      'dateRegistered': instance.dateRegistered,
    };
