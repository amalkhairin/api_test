import 'dart:convert';
import 'package:http/http.dart' as http;

class GetCountry{
  static Future<dynamic> getCountry(String name) async {
    try {
      var url = "https://restcountries.eu/rest/v2/name/$name";
      var response = await http.get(url);

      if(response.statusCode == 200){
        var resJson = json.decode(response.body);
        return resJson;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}