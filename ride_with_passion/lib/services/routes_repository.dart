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
        if (getIt<AuthService>()?.user?.debugUser ?? false) {
          getIt<FirebaseService>().getRoutes(true).listen((data) {
            routes.add(data);
            logger.i("${routes.value.length} Routes fetched");
          });
        } else {
          getIt<FirebaseService>().getRoutes(false).listen((data) {
            routes.add(data);
            logger.i("${routes.value.length} Routes fetched");
          });
        }
      }
    });
  }
}
