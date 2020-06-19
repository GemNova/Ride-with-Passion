import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/services/timer_service.dart';
import 'package:ride_with_passion/views/screens/onboarding_screen.dart';
import 'package:ride_with_passion/views/widgets/timer_countdown_widget.dart';
import 'package:rxdart/rxdart.dart';

class BikeChallengeTimerViewModel extends ChangeNotifier {
  final TimerService _timerService = getIt<TimerService>();
  final AuthService _authService = getIt<AuthService>();

  ChallengeRoute challengeRoute;

  BehaviorSubject<String> get timerCounter => _timerService.timerCounter;

  BehaviorSubject<bool> get running => _timerService.running;

  BikeChallengeTimerViewModel(ChallengeRoute challengeRoute) {
    this.challengeRoute = challengeRoute;
    if (!_timerService.running.value) {
      //Get.dialog(OnboardingScreen());

      Future.delayed(Duration(seconds: 10)).then((value) {
        if (!_timerService.running.value)
          _timerService.startWithChallenge(challengeRoute);
      });
    }
  }

  bool get isDebugUser => _authService.user.debugUser;

  finishChallenge() async {
    _timerService.finishChallenge();
  }

  stopTimer() async {
    await _timerService.stopFromButton();
    Get.offNamed(BikeChallengesStartRoute, arguments: challengeRoute);
  }

  startTimer() {
    _timerService.startWithChallenge(challengeRoute);
  }
}
