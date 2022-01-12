import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_exception.dart';

///Подготовленный методы для отправка POST, GET, PUT, DELETE запроса
class ApiProvider {
  Future<Map<String, dynamic>> post(String url, dynamic body) async {
    print(url + ' ' + body.toString());

    dynamic responseJson;
    try {
      final dynamic response = await http.post(Uri.parse(url), body: jsonEncode(body));
      responseJson = await _response(response);
    } on SocketException {
      throw ApiException(ApiExceptionType.NETWORK);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(ApiExceptionType.OTHER);
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> delete(String url, dynamic body) async {
    print(url + ' ' + body.toString());
    dynamic responseJson;
    try {
      final dynamic response = await http.delete(Uri.parse(url), body: jsonEncode(body));
      responseJson = await _response(response);
    } on SocketException {
      throw ApiException(ApiExceptionType.NETWORK);
    }
    return responseJson;
  }

  Future<List<Map<String, dynamic>>> postList(String url, dynamic body, {anotherToken}) async {
    print(url + ' ' + body.toString());
    dynamic responseJson;
    try {
      final dynamic response = await http.post(Uri.parse(url), body: body);
      responseJson = await _response(response);
    } on SocketException {
      throw ApiException(ApiExceptionType.NETWORK);
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> get(String url, {anotherToken, String query = ''}) async {
    print(url + query);

    dynamic responseJson;
    try {
      final dynamic response = await http.get(Uri.parse(url + query));
      responseJson = await _response(response);
    } on SocketException {
      throw ApiException(ApiExceptionType.NETWORK);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(ApiExceptionType.OTHER);
    }
    return responseJson;
  }

  Future<List<dynamic>> getList(String url, {anotherToken, String query = ''}) async {
    dynamic responseJson;
    try {
      final dynamic response = await http.get(Uri.parse(url + query));
      responseJson = await _response(response);
    } on SocketException {
      throw ApiException(ApiExceptionType.NETWORK);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(ApiExceptionType.OTHER);
    }
    return responseJson;
  }

  Map<String, String> getHeader(String token, {bool isMultipart = false}) {
    return {
      'content-type': isMultipart ? 'multipart/form-data' : 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ' + token,
    };
  }

  dynamic _response(response) async {
    dynamic responseJson;
    var resp = "";
    if (response is http.Response) {
      resp = response.body.toString();
      responseJson = json.decode(resp);
    } else if (response is http.StreamedResponse) {
      responseJson = json.decode(await response.stream.bytesToString());
    } else {
      throw UnsupportedError("Response type is unsupported");
    }

    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
        throw ApiException(ApiExceptionType.BADREQUEST);
      case 422:
        throw ApiException(ApiExceptionType.INVALIDDATA);
      case 401:
        throw ApiException(ApiExceptionType.UNAUTHORIZED);
      case 409:
        throw ApiException(ApiExceptionType.UNAUTHORIZED);
      case 403:
        throw ApiException(ApiExceptionType.UNAUTHORIZED);
      default:
        print("REQUEST: ${response.request.url}");
        print("CODE: " + response.statusCode.toString());
        print("RESPONSE: $resp");
        throw ApiException(ApiExceptionType.OTHER);
    }
  }
}
