import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:ride_with_passion/views/screens/bike_challenge_timer_screen.dart';
import 'package:ride_with_passion/views/widgets/custom_button.dart';
import 'package:ride_with_passion/views/widgets/custom_textfield.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  String email;
  String password;

  String changeEmail = '';

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
        Get.offAllNamed(HomeRoute);
      }).catchError((error) {
        isLoading = false;
        notifyListeners();
        return Get.snackbar("Da ist wohl etwas schiefgelaufen", error);
      }).whenComplete(() {
        isLoading = false;
        //notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  void onRegisterPressed() {
    Get.toNamed(RegisterRoute);
  }

  forgotPasswordPressed() {
    Get.dialog(Dialog(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(
                "Bitte gib deine Email Addresse ein um dein Passwort zurückzusetzen",
                style: title18cb),
            smallSpace,
            CustomTextField(
              onChanged: (value) => changeEmail = value,
              keyboardType: TextInputType.emailAddress,
            ),
            smallSpace,
            CustomButton(
              padding: EdgeInsets.all(16),
              text: "Absenden",
              onPressed: () {
                Get.back();
                return getIt<AuthService>().forgotPassword(changeEmail);
              },
            )
          ]),
        )));
  }
}
