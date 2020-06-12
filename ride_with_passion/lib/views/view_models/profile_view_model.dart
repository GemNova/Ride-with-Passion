import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:ride_with_passion/services/timer_service.dart';

class ProfileViewModel extends ChangeNotifier {
  get userStream => getIt<AuthService>().userStream;
  final _firebaseService = getIt<FirebaseService>();

  List<Rank> rankList = [];

  ProfileViewModel() {
    // ranks();
  }

  handleEditProfileButton() {
    Get.toNamed(EditProfileRoute);
  }

  onLogoutPressed() {
    getIt<TimerService>().stopFromButton();
    getIt<AuthService>().logout();
  }

  ranks() async {
    rankList =
        await _firebaseService.getRanksForUser(getIt<AuthService>().user?.id);
    notifyListeners();
  }
}
