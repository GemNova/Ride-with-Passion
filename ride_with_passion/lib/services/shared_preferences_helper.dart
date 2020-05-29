import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _pref_onboarding_done = "_pref_onboarding_done";
  Future isOnboardingDone() async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(_pref_onboarding_done) ?? Future.value(false);
  }

  Future<bool> setOnboardingDone() async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.setBool(_pref_onboarding_done, true);
  }
}
