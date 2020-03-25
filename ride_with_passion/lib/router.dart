import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/views/screens/bike_challenges_screen.dart';
import 'package:ride_with_passion/views/screens/home_screen.dart';
import 'package:ride_with_passion/views/screens/login_screen.dart';
import 'package:ride_with_passion/views/screens/register_screen.dart';

const String HomeRoute = '/home';
const String LoginRoute = '/login';
const String RegisterRoute = '/register';
const String BikeChallengesRoute = '/bike_challenge';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetRoute(
          page: LoginScreen(),
          settings: settings,
        );
      case LoginRoute:
        return GetRoute(settings: settings, page: LoginScreen());
      case RegisterRoute:
        return GetRoute(settings: settings, page: RegisterScreen());
      case BikeChallengesRoute:
        return GetRoute(settings: settings, page: BikeChallangesScreen());
      case HomeRoute:
        return GetRoute(
          settings: settings,
          page: HomeScreen(),
        );

      default:
        return GetRoute(
            settings: settings,
            page: Scaffold(
              appBar: AppBar(),
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
