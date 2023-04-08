import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_mvvm/src/data/api_state.dart';

class HttpManager {
  static Future requestManager(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response;
      }
      if (response.statusCode == 404) {
        return Failure(code: 404, failureResponse: 'City Not Fount');
      }
      return Failure(code: 100, failureResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: 101, failureResponse: 'No Internet');
    } on FormatException {
      return Failure(code: 102, failureResponse: 'Invalid Format');
    } on SocketException {
      return Failure(code: 102, failureResponse: 'No Internet Connection');
    } catch (e) {
      return Failure(code: 103, failureResponse: 'Unknown Error');
    }
  }
}
