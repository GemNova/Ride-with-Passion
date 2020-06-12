import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/function_utils.dart';
import 'package:ride_with_passion/helper/constants.dart';
import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/models/user.dart';
import 'package:ride_with_passion/router.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/services/routes_repository.dart';
import 'package:ride_with_passion/services/timer_service.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends ChangeNotifier {
  final _timerService = getIt<TimerService>();
  final _routeRepository = getIt<RoutesRepository>();

  BehaviorSubject<String> get timerCounter => _timerService.timerCounter;

  BehaviorSubject<bool> get running => _timerService.running;

  User get user => getIt<AuthService>().user;

  ChallengeRoute get challengeRoute => _timerService.challengeRoute;
  BehaviorSubject<List<ChallengeRoute>> _filteredRoutes = BehaviorSubject();

  Stream<List<Route>> list;

  HomeViewModel() {
    getIt<AuthService>().isLoggedIn.listen((value) {
      if (value) {
        notifyListeners();
      }
    });
  }

  BehaviorSubject<List<ChallengeRoute>> getRoutes(RouteType routeType) {
    String routeName = routeType.toString().split('.').last.toLowerCase();
    if (routeType == null) {
      return _routeRepository.routes;
    } else {
      List<ChallengeRoute> challengeRoutes = _routeRepository.routes.value;
      challengeRoutes = challengeRoutes
          .where((element) =>
              element.routeType.toLowerCase() == routeName.toLowerCase())
          .toList();

      //put featured route on top
      challengeRoutes.sort((a, b) {
        return b.compareTo(a);
      });
      _filteredRoutes.add(challengeRoutes);

      return _filteredRoutes;
    }
  }

  onProfilePressed() {
    Get.toNamed(ProfileRoute);
  }

  void onBikeChallengePressed({RouteType routeType}) {
    FunctionUtils.launchURL("http://bikechallenge.tirol");
  }

  void onChallengeDetailButtonPressed(ChallengeRoute challengeRoute) {
    Get.toNamed(BikeChallengesDetailRoute, arguments: challengeRoute);
  }

  void onPartnerPressed() {
    Get.toNamed(PartnerRoute);
  }
}
