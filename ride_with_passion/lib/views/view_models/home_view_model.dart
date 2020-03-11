import 'package:flutter/material.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/services/auth_service.dart';

class HomeViewModel extends ChangeNotifier {
  onLogoutPressed() {
    getIt<AuthService>().logout();
  }
}
