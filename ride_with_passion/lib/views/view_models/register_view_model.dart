import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/views/screens/onboarding_screen.dart';

class RegisterViewModel extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  String firstName;
  String lastName;
  String email;
  String password;
  String type;
  String gender;
  File image;
  DateTime birthDate;
  String street;
  String houseNumber;
  String city;
  String postCode;
  String country;

  bool tcValue = false;
  bool tc1Value = false;

  List<String> types = ['Bike', 'E-Bike'];

  List<String> genders = ['Männlich', 'Weiblich'];

  bool get isButtonEnabled =>
      (lastName?.isNotEmpty ?? false) &&
      (firstName?.isNotEmpty ?? false) &&
      (password?.isNotEmpty ?? false) &&
      (email?.isNotEmpty ?? false) &&
      (type != null) &&
      // (gender != null) &&
      tcValue;

  setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  setEmail(String email) {
    this.email = email;
    notifyListeners();
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

  onRegisterPressed() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      isLoading = true;
      notifyListeners();
      getIt<AuthService>()
          .registerUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        bikeType: type,
        gender: gender ?? "Männlich",
        image: image,
        birthDate: birthDate,
        street: street,
        houseNumber: houseNumber,
        gewinnSpiel: tc1Value,
        city: city,
        postCode: postCode,
        country: country,
      )
          .then((_) {
        Get.offAllNamed(HomeRoute);
        Get.dialog(OnboardingScreen());
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

  void onLoginPressed() {
    Get.back();
  }

  void setTcValue(bool value) {
    tcValue = value;
    notifyListeners();
  }

  void setTc1Value(bool value) {
    tc1Value = value;
    notifyListeners();
  }
}
