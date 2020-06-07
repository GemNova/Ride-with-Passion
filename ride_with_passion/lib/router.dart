import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/views/screens/bike_challenge_end_screen.dart';
import 'package:ride_with_passion/views/screens/bike_challenge_start_screen.dart';
import 'package:ride_with_passion/views/screens/bike_challenge_timer_screen.dart';
import 'package:ride_with_passion/views/screens/bike_challenges_screen.dart';
import 'package:ride_with_passion/views/screens/edit_profile_screen.dart';
import 'package:ride_with_passion/views/screens/home_screen.dart';
import 'package:ride_with_passion/views/screens/login_screen.dart';
import 'package:ride_with_passion/views/screens/partner_screen.dart';
import 'package:ride_with_passion/views/screens/profile_screen.dart';
import 'package:ride_with_passion/views/screens/register_screen.dart';

import 'views/screens/bike_challenge_detail_screen.dart';

const String HomeRoute = '/home';
const String LoginRoute = '/login';
const String RegisterRoute = '/register';
const String BikeChallengesRoute = '/bike_challenge';
const String BikeChallengesDetailRoute = '/bike_challenge_detail';
const String BikeChallengesStartRoute = '/bike_challenge_start';
const String BikeChallengesTimerRoute = '/bike_challenge_timer';
const String BikeChallengesEndRoute = '/bike_challenge_end';
const String PartnerRoute = '/partner';
const String ProfileRoute = '/profile';
const String EditProfileRoute = '/edit-profile';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetRouteBase(
          page: LoginScreen(),
          settings: settings,
        );
      case LoginRoute:
        return GetRouteBase(settings: settings, page: LoginScreen());
      case RegisterRoute:
        return GetRouteBase(settings: settings, page: RegisterScreen());
      case BikeChallengesRoute:
        return GetRouteBase(
            settings: settings,
            page: BikeChallangesScreen(routeType: settings.arguments));
      case BikeChallengesDetailRoute:
        return GetRouteBase(
            settings: settings,
            page: BikeChallangesDetailScreen(settings.arguments));
      case BikeChallengesStartRoute:
        return GetRouteBase(
            settings: settings,
            page: BikeChallengeStartScreen(settings.arguments));
      case BikeChallengesTimerRoute:
        return GetRouteBase(
            settings: settings,
            page: BikeChallengeTimerScreen(settings.arguments));
      case BikeChallengesEndRoute:
        return GetRouteBase(
            settings: settings,
            page: BikeChallengeEndScreen(route: settings.arguments));
      case PartnerRoute:
        return GetRouteBase(settings: settings, page: PartnerScreen());
      case ProfileRoute:
        return GetRouteBase(
          settings: settings,
          page: ProfileScreen(),
        );
      case EditProfileRoute:
        return GetRouteBase(
          settings: settings,
          page: EditProfileScreen(),
        );
      case HomeRoute:
        return GetRouteBase(
          settings: settings,
          page: HomeScreen(),
        );

      default:
        return GetRouteBase(
            settings: settings,
            page: Scaffold(
              appBar: AppBar(),
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
