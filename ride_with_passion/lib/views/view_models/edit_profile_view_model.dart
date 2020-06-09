import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/user.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';

class EditProfileViewModel extends ChangeNotifier {
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final User user = getIt<AuthService>().userStream?.value;

  TextEditingController textEditingControllerFirstName =
      TextEditingController();
  TextEditingController textEditingControllerLastName = TextEditingController();
  TextEditingController textEditingControllerStreet = TextEditingController();
  TextEditingController textEditingControllerHouseNumber =
      TextEditingController();
  TextEditingController textEditingControllerCity = TextEditingController();
  TextEditingController textEditingControllerPostCode = TextEditingController();
  TextEditingController textEditingControllerCountry = TextEditingController();

  String firstName;
  String lastName;
  String type;
  String gender;
  File image;
  String imageUrl;
  DateTime birthDate;
  String street;
  String houseNumber;
  String city;
  String postCode;
  String country;

  init() {
    textEditingControllerFirstName.text = user.firstName;
    textEditingControllerLastName.text = user.lastName;
    textEditingControllerStreet.text = user.street;
    textEditingControllerHouseNumber.text = user.houseNumber;
    textEditingControllerCity.text = user.city;
    textEditingControllerPostCode.text = user.postCode;
    textEditingControllerCountry.text = user.country;
    firstName = user.firstName;
    lastName = user.lastName;
    street = user.street;
    houseNumber = user.houseNumber;
    city = user.city;
    postCode = user.postCode;
    country = user.country;
    imageUrl = user.imageUrl;
    birthDate = user.birthDate;
    gender = user.gender;
    type = user.bikeType;
  }

  List<String> types = ['Bike', 'E-Bike'];

  List<String> genders = ['Männlich', 'Weiblich'];

  bool isButtonEnabled() {
    return (lastName?.isNotEmpty ?? false) &&
        (firstName?.isNotEmpty ?? false) &&
        (type != null) &&
        (gender != null);
  }

  setFirstName(String firstName) {
    this.firstName = firstName;
    notifyListeners();
  }

  setLastName(String lastName) {
    this.lastName = lastName;
    notifyListeners();
  }

  setType(String type) {
    this.type = type;
    notifyListeners();
  }

  setGender(String gender) {
    this.gender = gender;
    notifyListeners();
  }

  void setImage(File image) {
    if (image == null) return;
    this.image = image;
    notifyListeners();
  }

  setBirthday(DateTime birthday) {
    this.birthDate = birthday;
    notifyListeners();
  }

  setStreet(String street) {
    this.street = street;
    notifyListeners();
  }

  setHouseNumber(String houseNumber) {
    this.houseNumber = houseNumber;
    notifyListeners();
  }

  setCity(String city) {
    this.city = city;
    notifyListeners();
  }

  setPostCode(String postCode) {
    this.postCode = postCode;
    notifyListeners();
  }

  setCountry(String country) {
    this.country = country;
    notifyListeners();
  }

  onEditPressed() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      isLoading = true;
      notifyListeners();

      getIt<AuthService>()
          .editUser(
        id: user.id,
        firstName: firstName,
        lastName: lastName,
        bikeType: type,
        gender: gender,
        imageUrl: imageUrl,
        image: image,
        birthDate: birthDate,
        street: street,
        houseNumber: houseNumber,
        city: city,
        postCode: postCode,
        country: country,
      )
          .then((_) {
        Get.back();
      }).catchError((error) {
        return Get.snackbar("Da ist wohl etwas schiefgelaufen", error);
      }).whenComplete(() {
        isLoading = false;
        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }
}
