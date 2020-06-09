import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/function_utils.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/logger.dart';
import 'package:ride_with_passion/models/challenge.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/models/timer.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/location_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerService {
  final log = getLogger("TimerService");
  Isolate _isolate;
  int _counterTime = 1;
  ReceivePort _receivePort;
  String _routeId;
  String _routeName;
  Position _endRouteChallenge;
  ChallengeRoute _challengeRoute;
  SharedPreferences _prefs;
  Challenge _challengeData;

  final _locationService = getIt<LocationService>();
  BehaviorSubject<String> _timerCounter = BehaviorSubject()..add('00:00:00');
  BehaviorSubject<bool> _running = BehaviorSubject()..add(false);
  BehaviorSubject<bool> _isCompleteChallenge = BehaviorSubject()..add(false);

  BehaviorSubject<String> get timerCounter => _timerCounter;

  BehaviorSubject<bool> get running => _running;

  BehaviorSubject<bool> get isCompletedChallenge => _isCompleteChallenge;

  String get routeName => _routeName;

  ChallengeRoute get challengeRoute => _challengeRoute;

  void startWithChallenge(ChallengeRoute challengeRoute) async {
    initValueWhenStart(challengeRoute);
    await checkTimerFromSetting();
    await startTheChallenge();
    await saveToSetting();
  }

  void startFromResume() async {
    log.i(' start from resume $_routeId');
    if (await isSettingTimerEmpty() || await isReachedEndLine()) {
      return;
    }
    await checkTimerFromSetting();
    await startTheChallenge();
  }

  void startWithoutRouteId() async {
    ChallengeRoute challengeRouteFromSetting = await checkTimerFromSetting();
    if (challengeRouteFromSetting == null) {
      log.i('not found any key');
      return;
    } else {
      initValueWhenStart(challengeRouteFromSetting);
      await startTheChallenge();
    }
  }

  initValueWhenStart(ChallengeRoute challengeRoute) {
    _challengeData = Challenge(
      userId: DateTime.now().microsecondsSinceEpoch,
      rankList: challengeRoute.rankList,
      challengeName: challengeRoute.name,
      trackId: challengeRoute.routeId,
    );
    _challengeRoute = challengeRoute;
    _endRouteChallenge = Position(
        latitude: challengeRoute.endCoordinates.lat,
        longitude: challengeRoute.endCoordinates.lon);
    _routeId = challengeRoute.routeId;
    _routeName = challengeRoute.name;
    _isCompleteChallenge.add(false);
  }

  startTheChallenge() async {
    _running.add(true);
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_checkTimer, _receivePort.sendPort);
    _receivePort.listen(_handleMessage, onDone: () {
      log.i("dart isolate stopped");
    });
    listenWhenReachedEndLine();
  }

  Future<bool> isReachedEndLine() async {
    if (_endRouteChallenge == null) {
      return false;
    }
    Position position = await _locationService.getCurrentPosition();
    final initDistance =
        await _locationService.getDistance(_endRouteChallenge, position);
    return FunctionUtils.isDoubleBelow(initDistance);
  }

  listenWhenReachedEndLine() async {
    if (_endRouteChallenge == null) {
      log.i('no end route chalange');
      return;
    }
    if (await isReachedEndLine() && running.value) {
      stopFromButton();
      _challengeData.duration = Duration(seconds: _counterTime);
      Get.toNamed(BikeChallengesEndRoute, arguments: _challengeData);
    }
    _locationService.getUpdateLocation((newPosition) {
      log.i(
          'position updated, current position ${newPosition.latitude} ${newPosition.longitude} end line ${_endRouteChallenge.latitude} ${_endRouteChallenge.longitude}');
      _locationService
          .getDistance(_endRouteChallenge, newPosition)
          .then((distance) async {
        if (await FunctionUtils.isDoubleBelow(distance) && running.value) {
          _isCompleteChallenge.value = true;
          _challengeData.duration = Duration(seconds: _counterTime);
          log.i('distance is less 50m from end line, distance $distance');
          log.i('challenge data saved is ${_challengeData.duration.inSeconds}');
          stopFromButton();
          Get.toNamed(BikeChallengesEndRoute, arguments: _challengeData);
        } else {
          log.i('distance is more 50m from end line, distance $distance');
        }
      });
    });
  }

  Future<bool> isAllowedToTimerScreen(ChallengeRoute challengeRoute) async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('pref_timer') != null) {
      TimerObject timerObject =
          TimerObject.fromJson(json.decode(_prefs.getString('pref_timer')));
      if (timerObject.challengeRoute.routeId == challengeRoute.routeId) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<bool> isSettingTimerEmpty() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('pref_timer') != null) {
      return false;
    } else {
      return true;
    }
  }

  Future<ChallengeRoute> checkTimerFromSetting() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('pref_timer') != null) {
      TimerObject timerObject =
          TimerObject.fromJson(json.decode(_prefs.getString('pref_timer')));
      if (timerObject != null) {
        DateTime startTime = timerObject.startTime;
        DateTime dateTimeNow = DateTime.now();
        final difference = dateTimeNow.difference(startTime).inSeconds;
        _counterTime = difference;
        _timerCounter.add(formattedTimer(Duration(seconds: _counterTime)));
        log.i('_counter sstart in $_counterTime');
      }
      return timerObject.challengeRoute;
    } else {
      log.i('timer in setting is null');
      return null;
    }
  }

  Future saveToSetting() async {
    log.i('save to setting ${_challengeRoute.name}');
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(
        'pref_timer',
        json.encode(TimerObject(
            startTime: DateTime.now(), challengeRoute: _challengeRoute)));
    log.i(
        'setting saved. time ${DateTime.now()} route name: ${_challengeRoute.name}');
  }

  static void _checkTimer(SendPort sendPort) async {
    Timer.periodic(new Duration(seconds: 1), (Timer t) {
      sendPort.send(1);
    });
  }

  void _handleMessage(dynamic data) {
    _counterTime = _counterTime + data;
    _timerCounter.value = formattedTimer(Duration(seconds: _counterTime));
  }

  stopFromButton() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove('pref_timer');
    await stopTimer();
  }

  stopTimer() async {
    if (_isolate != null && _routeId != null) {
      _running.add(false);
      _counterTime = 0;
      _timerCounter.add('00:00:00');
      _receivePort.close();
      _isolate.kill(priority: Isolate.immediate);
      _isolate = null;
    }
  }

  static String formattedTimer(Duration duration) {
    String twoDigits(int n, {int pad: 2}) {
      var str = n.toString();
      var paddingToAdd = pad - str.length;
      return (paddingToAdd > 0)
          ? "${new List.filled(paddingToAdd, '0').join('')}$str"
          : str;
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
