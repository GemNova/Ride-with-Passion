// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  return User(
    id: json['id'] as String,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    bikeType: json['bikeType'] as String,
    gender: json['gender'] as String,
    imageUrl: json['imageUrl'] as String,
    birthDate: timeStampToDateFromJson(json['birthDate'] as Timestamp),
    city: json['city'] as String,
    country: json['country'] as String,
    houseNumber: json['houseNumber'] as String,
    postCode: json['postCode'] as String,
    street: json['street'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('bikeType', instance.bikeType);
  writeNotNull('gender', instance.gender);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('birthDate', dateTimeToTimeStampToJson(instance.birthDate));
  writeNotNull('street', instance.street);
  writeNotNull('houseNumber', instance.houseNumber);
  writeNotNull('city', instance.city);
  writeNotNull('postCode', instance.postCode);
  writeNotNull('country', instance.country);
  return val;
}
