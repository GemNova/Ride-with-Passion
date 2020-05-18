import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/services/firebase_service.dart';

class FunctionUtils {
  static Future<bool> isDoubleBelow(double distance) async{
    double comparator = await getIt<FirebaseService>().getMinimumMeter();
    return distance < comparator;
  }
}
