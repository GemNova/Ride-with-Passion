import 'package:get_it/get_it.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:ride_with_passion/services/routes_repository.dart';
import 'package:ride_with_passion/services/shared_preferences_helper.dart';
import 'package:ride_with_passion/services/timer_service.dart';
import 'package:ride_with_passion/views/view_models/home_view_model.dart';

import 'services/location_service.dart';

GetIt getIt = GetIt.instance;

setupLocator() {
  getIt.registerSingleton(FirebaseService());
  getIt.registerSingleton(AuthService());
  getIt.registerSingleton(LocationService());
  getIt.registerSingleton(RoutesRepository());
  getIt.registerSingleton(TimerService());
  getIt.registerSingleton(SharedPreferencesHelper());
  getIt.registerSingleton(HomeViewModel());
}
