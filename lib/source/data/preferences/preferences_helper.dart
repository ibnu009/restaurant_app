import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const DAILY_NEWS = 'DAILY_NEWS';

  Future<bool> get isDailyNewsActive async {
    final pref = await sharedPreferences;
    return pref.getBool(DAILY_NEWS) ?? false;
  }

  void setDailyNews(bool value) async {
    final pref = await sharedPreferences;
    pref.setBool(DAILY_NEWS, value);
  }
}
