import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/timer_service.dart';
import 'package:rxdart/rxdart.dart';

class BikeChallengeTimerViewModel extends ChangeNotifier {
  final TimerService _timerService = getIt<TimerService>();
  ChallengeRoute challengeRoute;

  BehaviorSubject<String> get timerCounter => _timerService.timerCounter;

  BehaviorSubject<bool> get running => _timerService.running;

  BikeChallengeTimerViewModel(ChallengeRoute challengeRoute) {
    this.challengeRoute = challengeRoute;
    if (!_timerService.running.value) {
      _timerService.startWithChallenge(challengeRoute);
    }
  }

  stopTimer() async {
    await _timerService.stopFromButton();
    Get.offNamed(BikeChallengesStartRoute, arguments: challengeRoute);
  }

  startTimer() {
    _timerService.startWithChallenge(challengeRoute);
  }
}
