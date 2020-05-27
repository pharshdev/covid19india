import 'package:shared_preferences/shared_preferences.dart';

import 'api_client.dart';

class Repo {
  final ApiClient apiClient = ApiClient();
  SharedPreferences userPrefs;

  Future<void> loadPrefs() async {
    userPrefs = await SharedPreferences.getInstance();
    return;
  }

  void switchNightMode() async {
    await userPrefs.setBool('nightmode', !getNightMode());
  }

  bool getNightMode() {
    return userPrefs.getBool('nightmode') ?? false;
  }

  Future<dynamic> getNationalData() {
    return apiClient.fetchNationalData();
  }
}
