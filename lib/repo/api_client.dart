import 'package:covid19india/models/national_data.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final httpClient = http.Client();

  Future<dynamic> fetchNationalData() async {
    try {
      final response = await http.get('https://api.covid19india.org/data.json');

      if (response.statusCode != 200)
        return Future.error(response.body);
      else
        return nationalDataFromJson(response.body);
    } catch (e) {
      return Future.value(e.toString());
    }
  }
}
