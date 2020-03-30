import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/logger.dart';
import 'package:ride_with_passion/models/route.dart';
import 'package:ride_with_passion/services/auth_service.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:rxdart/subjects.dart';

class RoutesRepository {
  BehaviorSubject<List<ChallengeRoute>> routes = BehaviorSubject();
  final logger = getLogger("RoutesRepository");

  RoutesRepository() {
    _init();
  }

  _init() {
    getIt<AuthService>().isLoggedIn.listen((isLoggedIn) {
      if (isLoggedIn) {
        getIt<FirebaseService>().getRoutes().listen((data) {
          routes.add(data);
          logger.i("${data.length} Routes fetched");
        });
      }
    });
  }
}
