import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';

class ScraperAPI {

  final endpoint = "http://127.0.0.1:5000";

  Future scrapeWebsite(linkToScrape) async {
    var response;

    try {
      response = await http.post(endpoint + '/scrape',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'link': linkToScrape,
          }));
    } catch (e) {
      return ({
        "status": "Error",
        "msg": "There were connection problems, Sorry!",
      });
    }

    if (response.statusCode == 200) {
      var reportsJson = json.decode(response.body);
      return reportsJson;

    } else {
      return ({
        "status": "Error",
        "msg": "Response code != 200",
      });
    }
  }
}