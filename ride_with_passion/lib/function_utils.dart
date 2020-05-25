import 'package:ride_with_passion/locator.dart';
import 'package:ride_with_passion/services/firebase_service.dart';
import 'package:url_launcher/url_launcher.dart';

class FunctionUtils {
  static Future<bool> isDoubleBelow(double distance) async {
    double comparator = await getIt<FirebaseService>().getMinimumMeter();
    return distance < comparator;
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
