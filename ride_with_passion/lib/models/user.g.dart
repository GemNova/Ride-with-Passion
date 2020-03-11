// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  return User(
    userId: json['userID'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userID': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
    };
