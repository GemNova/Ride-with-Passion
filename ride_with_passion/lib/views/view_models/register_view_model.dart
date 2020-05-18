import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  String firstName;
  String lastName;
  String email;
  String password;
  String type;

  bool tcValue = false;
  bool tc1Value = false;

  List<String> types = ['E-Bike', 'Bike'];

  bool get isButtonEnabled =>
      (lastName?.isNotEmpty ?? false) &&
      (firstName?.isNotEmpty ?? false) &&
      (password?.isNotEmpty ?? false) &&
      (email?.isNotEmpty ?? false) &&
      (type != null) &&
      tcValue &&
      tc1Value;

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
              bikeType: type)
          .then((_) {
        Get.offAllNamed(HomeRoute);
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
