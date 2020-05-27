import 'package:covid19india/models/national_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_store.dart';

class Repo {
  SharedPreferences userPrefs;

  Future<void> loadPrefs() async {
    userPrefs = await SharedPreferences.getInstance();
  }

  void switchNightMode() async {
    await userPrefs.setBool('nightmode', !getNightMode());
  }

  bool getNightMode() {
    return userPrefs.getBool('nightmode') ?? false;
  }

  Future<dynamic> getNationalData() {
    return Future.value(nationalDataFromJson(nationalData));
  }
}
