import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class APIService {
  fetchData({String url, String value}) async {
    final fetchUrl = Uri.encodeFull(url);
    final headers = {"Accept": "application/json"};
    final response = await http.post(fetchUrl, headers: headers);
    if (response.statusCode != 200) {
      throw "Error While Retrieving Data from Firebase";
    }
    JsonDecoder _decoder = new JsonDecoder();
    return _decoder.convert(response.body);
  }
}
