import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

DateTime timeStampToDateFromJson(Timestamp timestamp) {
  if (timestamp == null) return null;
  return DateTime.fromMillisecondsSinceEpoch(timestamp?.millisecondsSinceEpoch);
}

Timestamp dateTimeToTimeStampToJson(DateTime time) {
  if (time == null) return null;
  return Timestamp.fromDate(time);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
  includeIfNull: false,
)
class User {
  String id;
  String email;
  String firstName;
  String lastName;
  String bikeType;
  String gender;
  String imageUrl;
  @JsonKey(fromJson: timeStampToDateFromJson, toJson: dateTimeToTimeStampToJson)
  DateTime birthDate;
  String street;
  String houseNumber;
  String city;
  String postCode;
  String country;
  bool gewinnSpiel;
  bool debugUser;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.bikeType,
    this.gender,
    this.imageUrl,
    this.birthDate,
    this.debugUser,
    this.city,
    this.country,
    this.houseNumber,
    this.gewinnSpiel,
    this.postCode,
    this.street,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
