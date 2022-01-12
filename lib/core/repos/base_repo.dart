

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:test_flutter_app/core/constants/system.dart';
import 'package:test_flutter_app/core/http/api_provider.dart';

///Базовый репо который другие репозиторий наследуеть
class BaseRepo {
  ApiProvider? httpClient;

  BaseRepo({this.httpClient});

  String urlV1Part(String part) {
    return '${urlV1()}$part';
  }

  String urlV2Part(String part) {
    return '${urlV2()}$part';
  }

  String urlV1() {
    return '${System.BASE_URL}/v1';
  }

  String urlV2() {
    return '${System.BASE_URL}/v2';
  }

  ///генератор для параметр запроса, но в этом проекте я не использовал
  String generateQuery(Map<String, dynamic> params) {
    StringBuffer buffer = StringBuffer("?");
    params.forEach((key, value) {
      buffer.write("$key=$value&");
    });
    return buffer.toString();
  }

  ///Ручной проверка интернета
  Future<bool> checkConnection() async {
    if (kIsWeb) {
      return true;
    }
    try {
      final result = await InternetAddress.lookup('google.com').timeout(
        const Duration(milliseconds: 200),
        onTimeout: () => [],
      );
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
