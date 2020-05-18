import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/challenge.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/services/firebase_service.dart';

class BikeChallengeEndViewModel extends ChangeNotifier {
  final _firebaseService = getIt<FirebaseService>();
  Rank userRank;

  initUserRank(Challenge route, String usernamae) {
    final user = getIt<AuthService>().user;
    final int timeInMilli = route.duration.inMilliseconds;
    //so i think we do it like this
    userRank = Rank(
        bikeType: user.bikeType,
        trackedTime: timeInMilli,
        userName: user.firstName,
        userId: user.id);
    //later we will filter the userRank list by biketype in choicechip
    sendRank(route.trackId);
  }

  void sendRank(String routeId) {
    _firebaseService.sendRank(userRank, routeId);
  }

  void onBikeChallengeComplete() {
    Get.offNamed(HomeRoute);
  }
}
