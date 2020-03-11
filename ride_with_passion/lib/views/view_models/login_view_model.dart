import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  String email;
  String password;

  setPassword(String password) {
    this.password = password;
  }

  setEmail(String email) {
    this.email = email;
  }

  onLoginPressed() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      isLoading = true;
      notifyListeners();
      getIt<AuthService>()
          .loginUser(email: email, password: password)
          .then((_) {
        // Get.offAllNamed(DashboardRoute);
      }).catchError((error) {
        isLoading = false;
        notifyListeners();
        return Get.snackbar("Da ist wohl etwas schiefgelaufen", error);
      });
    } else {
      notifyListeners();
    }
  }
}
