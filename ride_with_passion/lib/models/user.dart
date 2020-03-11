import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class User {
  String userId;
  String email;
  String authId;
  String name;
  String username;

  User({
    this.userId,
    this.email,
    this.name,
    this.authId,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
