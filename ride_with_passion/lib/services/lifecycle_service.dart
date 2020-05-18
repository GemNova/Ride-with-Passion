import 'package:flutter/material.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/services/timer_service.dart';

class LifecycleService extends WidgetsBindingObserver {
  final TimerService _timerService = getIt<TimerService>();

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await _timerService.stopTimer();
        break;
      case AppLifecycleState.resumed:
        _timerService.startFromResume();
    }
  }
}
