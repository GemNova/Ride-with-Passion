import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passion/views/screens/home_screen.dart';
import 'package:ride_with_passion/views/screens/login_screen.dart';

const String HomeRoute = '/home';
const String LoginRoute = '/login';

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
