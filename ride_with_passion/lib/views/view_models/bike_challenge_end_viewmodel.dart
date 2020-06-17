import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/challenge.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/models/user.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/services/firebase_service.dart';

class BikeChallengeEndViewModel extends ChangeNotifier {
  final _firebaseService = getIt<FirebaseService>();
  final user = getIt<AuthService>().user;
  int rankNumber;
  bool isLoading = false;
  Rank userRank;

  initUserRank(Challenge route) async {
    isLoading = true;
    notifyListeners();
    final int timeInMilli = route.duration.inMilliseconds;
    //so i think we do it like this
    userRank = Rank(
        bikeType: user.bikeType,
        trackedTime: timeInMilli,
        userName: user.firstName,
        lastName: user.lastName,
        gender: user.gender,
        userId: user.id);
    //later we will filter the userRank list by biketype in choicechip
    rankNumber = await sendRank(route.trackId, user);
    isLoading = false;
    notifyListeners();
  }

  Future<int> sendRank(String routeId, User user) async {
    return await _firebaseService.sendRank(userRank, routeId, user);
  }

  void onBikeChallengeComplete() {
    Get.offNamed(HomeRoute);
  }
}
