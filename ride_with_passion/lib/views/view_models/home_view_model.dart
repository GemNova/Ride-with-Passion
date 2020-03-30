import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';

class HomeViewModel extends ChangeNotifier {
  Stream<List<Route>> list;
  onLogoutPressed() {
    getIt<AuthService>().logout();
  }

  void onBikeChallengePressed() {
    Get.toNamed(BikeChallengesRoute);
  }

  void onChallengeDetailButtonPressed(ChallengeRoute model){
    Get.toNamed(BikeChallengesDetailRoute, arguments:model );
  }
}
