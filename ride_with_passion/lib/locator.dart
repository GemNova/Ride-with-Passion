import 'package:get_it/get_it.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/services/firebase_service.dart';

GetIt getIt = GetIt.instance;

setupLocator() {
  getIt.registerSingleton(FirebaseService());
  getIt.registerSingleton(AuthService());
}
