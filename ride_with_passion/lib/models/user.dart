import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class User {
  String id;
  String email;
  String firstName;
  String lastName;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
