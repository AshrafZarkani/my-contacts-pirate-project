import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'custome_exception.dart';

class ApiProvider {
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, int numOfContacts) async {
    var responseJson;
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      };
      final Map<String, int> body = {"count": numOfContacts};
      var data = json.encode(body);
      final response = await http.post(Uri.parse(url),
          headers: headers, body: data, encoding: Encoding.getByName("utf-8"));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = (json.decode(response.body.toString()));
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
