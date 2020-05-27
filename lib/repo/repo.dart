import 'package:covid19india/models/national_data.dart';

import 'data_store.dart';

class Repo {
  Future<dynamic> getNationalData() {
    return Future.value(nationalDataFromJson(nationalData));
  }
}
